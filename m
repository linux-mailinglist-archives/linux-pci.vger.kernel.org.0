Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63AA816BEE1
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2020 11:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbgBYKgM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Feb 2020 05:36:12 -0500
Received: from foss.arm.com ([217.140.110.172]:48890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730186AbgBYKgM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Feb 2020 05:36:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BD3030E;
        Tue, 25 Feb 2020 02:36:11 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5FA63F6CF;
        Tue, 25 Feb 2020 02:36:09 -0800 (PST)
Date:   Tue, 25 Feb 2020 10:36:07 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     longli@linuxonhyperv.com
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Long Li <longli@microsoft.com>
Subject: Re: [Patch v4 2/2] PCI: hv: Add support for protocol 1.3 and support
 PCI_BUS_RELATIONS2
Message-ID: <20200225103607.GB4029@e121166-lin.cambridge.arm.com>
References: <1578946101-74036-1-git-send-email-longli@linuxonhyperv.com>
 <1578946101-74036-2-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578946101-74036-2-git-send-email-longli@linuxonhyperv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 13, 2020 at 12:08:21PM -0800, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> Starting with Hyper-V PCI protocol version 1.3, the host VSP can send
> PCI_BUS_RELATIONS2 and pass the vNUMA node information for devices on the
> bus. The vNUMA node tells which guest NUMA node this device is on based
> on guest VM configuration topology and physical device inforamtion.

s/inforamtion/information

Please rebase this series on top of my pci/hv branch, it does
not apply, I will merge it then.

Thanks,
Lorenzo

> Add code to negotiate v1.3 and process PCI_BUS_RELATIONS2.
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> ---
> Changes
> v2: Changed some spaces to tabs, added put_pcichild() after get_pcichild_wslot(), renamed pci_assign_numa_node() to hv_pci_assign_numa_node()
> v4: Fixed spelling
> 
>  drivers/pci/controller/pci-hyperv.c | 109 ++++++++++++++++++++++++++++
>  1 file changed, 109 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 3b3e1967cf08..147358fae8a2 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -63,6 +63,7 @@
>  enum pci_protocol_version_t {
>  	PCI_PROTOCOL_VERSION_1_1 = PCI_MAKE_VERSION(1, 1),	/* Win10 */
>  	PCI_PROTOCOL_VERSION_1_2 = PCI_MAKE_VERSION(1, 2),	/* RS1 */
> +	PCI_PROTOCOL_VERSION_1_3 = PCI_MAKE_VERSION(1, 3),	/* Vibranium */
>  };
>  
>  #define CPU_AFFINITY_ALL	-1ULL
> @@ -72,6 +73,7 @@ enum pci_protocol_version_t {
>   * first.
>   */
>  static enum pci_protocol_version_t pci_protocol_versions[] = {
> +	PCI_PROTOCOL_VERSION_1_3,
>  	PCI_PROTOCOL_VERSION_1_2,
>  	PCI_PROTOCOL_VERSION_1_1,
>  };
> @@ -124,6 +126,7 @@ enum pci_message_type {
>  	PCI_RESOURCES_ASSIGNED2		= PCI_MESSAGE_BASE + 0x16,
>  	PCI_CREATE_INTERRUPT_MESSAGE2	= PCI_MESSAGE_BASE + 0x17,
>  	PCI_DELETE_INTERRUPT_MESSAGE2	= PCI_MESSAGE_BASE + 0x18, /* unused */
> +	PCI_BUS_RELATIONS2		= PCI_MESSAGE_BASE + 0x19,
>  	PCI_MESSAGE_MAXIMUM
>  };
>  
> @@ -169,6 +172,26 @@ struct pci_function_description {
>  	u32	ser;	/* serial number */
>  } __packed;
>  
> +enum pci_device_description_flags {
> +	HV_PCI_DEVICE_FLAG_NONE			= 0x0,
> +	HV_PCI_DEVICE_FLAG_NUMA_AFFINITY	= 0x1,
> +};
> +
> +struct pci_function_description2 {
> +	u16	v_id;	/* vendor ID */
> +	u16	d_id;	/* device ID */
> +	u8	rev;
> +	u8	prog_intf;
> +	u8	subclass;
> +	u8	base_class;
> +	u32	subsystem_id;
> +	union	win_slot_encoding win_slot;
> +	u32	ser;	/* serial number */
> +	u32	flags;
> +	u16	virtual_numa_node;
> +	u16	reserved;
> +} __packed;
> +
>  /**
>   * struct hv_msi_desc
>   * @vector:		IDT entry
> @@ -304,6 +327,12 @@ struct pci_bus_relations {
>  	struct pci_function_description func[0];
>  } __packed;
>  
> +struct pci_bus_relations2 {
> +	struct pci_incoming_message incoming;
> +	u32 device_count;
> +	struct pci_function_description2 func[0];
> +} __packed;
> +
>  struct pci_q_res_req_response {
>  	struct vmpacket_descriptor hdr;
>  	s32 status;			/* negative values are failures */
> @@ -1417,6 +1446,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  		break;
>  
>  	case PCI_PROTOCOL_VERSION_1_2:
> +	case PCI_PROTOCOL_VERSION_1_3:
>  		size = hv_compose_msi_req_v2(&ctxt.int_pkts.v2,
>  					dest,
>  					hpdev->desc.win_slot.slot,
> @@ -1798,6 +1828,27 @@ static void hv_pci_remove_slots(struct hv_pcibus_device *hbus)
>  	}
>  }
>  
> +/*
> + * Set NUMA node for the devices on the bus
> + */
> +static void hv_pci_assign_numa_node(struct hv_pcibus_device *hbus)
> +{
> +	struct pci_dev *dev;
> +	struct pci_bus *bus = hbus->pci_bus;
> +	struct hv_pci_dev *hv_dev;
> +
> +	list_for_each_entry(dev, &bus->devices, bus_list) {
> +		hv_dev = get_pcichild_wslot(hbus, devfn_to_wslot(dev->devfn));
> +		if (!hv_dev)
> +			continue;
> +
> +		if (hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY)
> +			set_dev_node(&dev->dev, hv_dev->desc.virtual_numa_node);
> +
> +		put_pcichild(hv_dev);
> +	}
> +}
> +
>  /**
>   * create_root_hv_pci_bus() - Expose a new root PCI bus
>   * @hbus:	Root PCI bus, as understood by this driver
> @@ -1820,6 +1871,7 @@ static int create_root_hv_pci_bus(struct hv_pcibus_device *hbus)
>  
>  	pci_lock_rescan_remove();
>  	pci_scan_child_bus(hbus->pci_bus);
> +	hv_pci_assign_numa_node(hbus);
>  	pci_bus_assign_resources(hbus->pci_bus);
>  	hv_pci_assign_slots(hbus);
>  	pci_bus_add_devices(hbus->pci_bus);
> @@ -2088,6 +2140,7 @@ static void pci_devices_present_work(struct work_struct *work)
>  		 */
>  		pci_lock_rescan_remove();
>  		pci_scan_child_bus(hbus->pci_bus);
> +		hv_pci_assign_numa_node(hbus);
>  		hv_pci_assign_slots(hbus);
>  		pci_unlock_rescan_remove();
>  		break;
> @@ -2184,6 +2237,46 @@ static void hv_pci_devices_present(struct hv_pcibus_device *hbus,
>  		kfree(dr);
>  }
>  
> +/**
> + * hv_pci_devices_present2() - Handle list of new children
> + * @hbus:	Root PCI bus, as understood by this driver
> + * @relations2:	Packet from host listing children
> + *
> + * This function is the v2 version of hv_pci_devices_present()
> + */
> +static void hv_pci_devices_present2(struct hv_pcibus_device *hbus,
> +				    struct pci_bus_relations2 *relations)
> +{
> +	struct hv_dr_state *dr;
> +	int i;
> +
> +	dr = kzalloc(offsetof(struct hv_dr_state, func) +
> +		     (sizeof(struct hv_pcidev_description) *
> +		      (relations->device_count)), GFP_NOWAIT);
> +
> +	if (!dr)
> +		return;
> +
> +	dr->device_count = relations->device_count;
> +	for (i = 0; i < dr->device_count; i++) {
> +		dr->func[i].v_id = relations->func[i].v_id;
> +		dr->func[i].d_id = relations->func[i].d_id;
> +		dr->func[i].rev = relations->func[i].rev;
> +		dr->func[i].prog_intf = relations->func[i].prog_intf;
> +		dr->func[i].subclass = relations->func[i].subclass;
> +		dr->func[i].base_class = relations->func[i].base_class;
> +		dr->func[i].subsystem_id = relations->func[i].subsystem_id;
> +		dr->func[i].win_slot = relations->func[i].win_slot;
> +		dr->func[i].ser = relations->func[i].ser;
> +		dr->func[i].flags = relations->func[i].flags;
> +		dr->func[i].virtual_numa_node =
> +			relations->func[i].virtual_numa_node;
> +	}
> +
> +	if (hv_pci_start_relations_work(hbus, dr))
> +		kfree(dr);
> +}
> +
>  /**
>   * hv_eject_device_work() - Asynchronously handles ejection
>   * @work:	Work struct embedded in internal device struct
> @@ -2289,6 +2382,7 @@ static void hv_pci_onchannelcallback(void *context)
>  	struct pci_response *response;
>  	struct pci_incoming_message *new_message;
>  	struct pci_bus_relations *bus_rel;
> +	struct pci_bus_relations2 *bus_rel2;
>  	struct pci_dev_inval_block *inval;
>  	struct pci_dev_incoming *dev_message;
>  	struct hv_pci_dev *hpdev;
> @@ -2356,6 +2450,21 @@ static void hv_pci_onchannelcallback(void *context)
>  				hv_pci_devices_present(hbus, bus_rel);
>  				break;
>  
> +			case PCI_BUS_RELATIONS2:
> +
> +				bus_rel2 = (struct pci_bus_relations2 *)buffer;
> +				if (bytes_recvd <
> +				    offsetof(struct pci_bus_relations2, func) +
> +				    (sizeof(struct pci_function_description2) *
> +				     (bus_rel2->device_count))) {
> +					dev_err(&hbus->hdev->device,
> +						"bus relations v2 too small\n");
> +					break;
> +				}
> +
> +				hv_pci_devices_present2(hbus, bus_rel2);
> +				break;
> +
>  			case PCI_EJECT:
>  
>  				dev_message = (struct pci_dev_incoming *)buffer;
> -- 
> 2.17.1
> 
