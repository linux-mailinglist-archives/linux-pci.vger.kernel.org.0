Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82F65F756E
	for <lists+linux-pci@lfdr.de>; Fri,  7 Oct 2022 10:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiJGIoP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Oct 2022 04:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiJGIoL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Oct 2022 04:44:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAF7ABD6B;
        Fri,  7 Oct 2022 01:44:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C739DB8228B;
        Fri,  7 Oct 2022 08:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECD0C433D6;
        Fri,  7 Oct 2022 08:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665132246;
        bh=JQ5rrBqVeMWHmXF5BWkgqkCYkF+B1eRyJ838ZoluFKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FaAn9DTAvjX6R2SdVxaC5nELoqJXxHufpMnniZwX6Od0T93fxx1M3uNH/4zabbLXk
         1Olq6y08/OAVuJPai/rEPZuqsvjxy7m3qQaPgHna8fG+aSoyBb0Exvlt6aBLYcbiz0
         m732S1dRsGU9Mki43zEKT5iA52Eyk02t3zKgFHV2Hbb7yUmy3G4oj9ETUNNBncGkSi
         jPaUyPicbmOJkYyd7EAM1Fc7KLG5Kr5SzJ3ecWW+ese8AdEvyDVxAqyi5tB0gxhlpr
         6UccCtYIPB/jP9R60mcsmq96p3GwxUuAoZvUiRDEvAtOxpiurdJ2PX5+iI420quA7G
         DA1+a0EFNx74w==
Date:   Fri, 7 Oct 2022 10:43:56 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Frank Li <frank.li@nxp.com>
Cc:     "maz@kernel.org" <maz@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>,
        "lznuaa@gmail.com" <lznuaa@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v12 5/6] PCI: endpoint: pci-epf-vntb: Clean up
Message-ID: <Yz/mzIfH094vZIdb@lpieralisi>
References: <20220922161246.20586-1-Frank.Li@nxp.com>
 <20220922161246.20586-6-Frank.Li@nxp.com>
 <AM9PR04MB879387C0B0483E55B13DC331885C9@AM9PR04MB8793.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR04MB879387C0B0483E55B13DC331885C9@AM9PR04MB8793.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 06, 2022 at 02:25:01PM +0000, Frank Li wrote:

[...]

> [Frank Li] @Bjorn Helgaas, ping
> Patches[1-4] was already picked  by irqchip. 
> I think patch[5-6] should go through pci subsystem. 
> Any additional comments?

Yes. Don't mix clean-ups with new features. This patch
should be split it does too many things at once, group
the clean ups in different patches and send them as
a separate series.

Lorenzo

> > Remove unused field: epf_db_phy.
> > Remove __iomem before epf_db.
> > Change epf_db to u32* from void *
> > Remove duplicate check if (readl(ntb->epf_db + i * 4)).
> > Using sizeof(u32) instead of number 4 at all place.
> > 
> > Clean up sparse build warning:
> >   Using  epf_db[i] instead of readl() because epf_db is located in local
> >   memory and allocated by dma_alloc_coherent(). Sparse build warning
> > when
> >   there are not __iomem at readl().
> >   Added __iomem force type convert in vntb_epf_peer_spad_read\write()
> > and
> >   vntb_epf_spad_read\write(). This require strong order at read and write.
> > 
> > Replace pci_epc_mem_free_addr() with pci_epf_free_space() at error handle
> > path to match pci_epf_alloc_space().
> > 
> > Cleanup warning found by scripts/kernel-doc
> > Fix indentation of the struct epf_ntb_ctrl
> > Consolidate term
> >   host, host1 to HOST
> >   vhost, vHost, Vhost, VHOST2 to VHOST
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 157 ++++++++++--------
> >  1 file changed, 90 insertions(+), 67 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index 1466dd1904175..acea753af29ed 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -11,7 +11,7 @@
> >   * Author: Kishon Vijay Abraham I <kishon@ti.com>
> >   */
> > 
> > -/**
> > +/*
> >   * +------------+         +---------------------------------------+
> >   * |            |         |                                       |
> >   * +------------+         |                        +--------------+
> > @@ -99,20 +99,20 @@ enum epf_ntb_bar {
> >   *       NTB Driver               NTB Driver
> >   */
> >  struct epf_ntb_ctrl {
> > -	u32     command;
> > -	u32     argument;
> > -	u16     command_status;
> > -	u16     link_status;
> > -	u32     topology;
> > -	u64     addr;
> > -	u64     size;
> > -	u32     num_mws;
> > -	u32	reserved;
> > -	u32     spad_offset;
> > -	u32     spad_count;
> > -	u32	db_entry_size;
> > -	u32     db_data[MAX_DB_COUNT];
> > -	u32     db_offset[MAX_DB_COUNT];
> > +	u32 command;
> > +	u32 argument;
> > +	u16 command_status;
> > +	u16 link_status;
> > +	u32 topology;
> > +	u64 addr;
> > +	u64 size;
> > +	u32 num_mws;
> > +	u32 reserved;
> > +	u32 spad_offset;
> > +	u32 spad_count;
> > +	u32 db_entry_size;
> > +	u32 db_data[MAX_DB_COUNT];
> > +	u32 db_offset[MAX_DB_COUNT];
> >  } __packed;
> > 
> >  struct epf_ntb {
> > @@ -136,8 +136,7 @@ struct epf_ntb {
> > 
> >  	struct epf_ntb_ctrl *reg;
> > 
> > -	phys_addr_t epf_db_phy;
> > -	void __iomem *epf_db;
> > +	u32 *epf_db;
> > 
> >  	phys_addr_t vpci_mw_phy[MAX_MW];
> >  	void __iomem *vpci_mw_addr[MAX_MW];
> > @@ -156,12 +155,14 @@ static struct pci_epf_header epf_ntb_header = {
> >  };
> > 
> >  /**
> > - * epf_ntb_link_up() - Raise link_up interrupt to Virtual Host
> > + * epf_ntb_link_up() - Raise link_up interrupt to Virtual Host (VHOST)
> >   * @ntb: NTB device that facilitates communication between HOST and
> > VHOST
> >   * @link_up: true or false indicating Link is UP or Down
> >   *
> >   * Once NTB function in HOST invoke ntb_link_enable(),
> > - * this NTB function driver will trigger a link event to vhost.
> > + * this NTB function driver will trigger a link event to VHOST.
> > + *
> > + * Returns: Zero for success, or an error code in case of failure
> >   */
> >  static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
> >  {
> > @@ -175,9 +176,9 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool
> > link_up)
> >  }
> > 
> >  /**
> > - * epf_ntb_configure_mw() - Configure the Outbound Address Space for
> > vhost
> > - *   to access the memory window of host
> > - * @ntb: NTB device that facilitates communication between host and vhost
> > + * epf_ntb_configure_mw() - Configure the Outbound Address Space for
> > VHOST
> > + *   to access the memory window of HOST
> > + * @ntb: NTB device that facilitates communication between HOST and
> > VHOST
> >   * @mw: Index of the memory window (either 0, 1, 2 or 3)
> >   *
> >   *                          EP Outbound Window
> > @@ -194,7 +195,9 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool
> > link_up)
> >   * |        |              |           |
> >   * |        |              |           |
> >   * +--------+              +-----------+
> > - *  VHost                   PCI EP
> > + *  VHOST                   PCI EP
> > + *
> > + * Returns: Zero for success, or an error code in case of failure
> >   */
> >  static int epf_ntb_configure_mw(struct epf_ntb *ntb, u32 mw)
> >  {
> > @@ -219,7 +222,7 @@ static int epf_ntb_configure_mw(struct epf_ntb *ntb,
> > u32 mw)
> > 
> >  /**
> >   * epf_ntb_teardown_mw() - Teardown the configured OB ATU
> > - * @ntb: NTB device that facilitates communication between HOST and
> > vHOST
> > + * @ntb: NTB device that facilitates communication between HOST and
> > VHOST
> >   * @mw: Index of the memory window (either 0, 1, 2 or 3)
> >   *
> >   * Teardown the configured OB ATU configured in epf_ntb_configure_mw()
> > using
> > @@ -234,12 +237,12 @@ static void epf_ntb_teardown_mw(struct epf_ntb
> > *ntb, u32 mw)
> >  }
> > 
> >  /**
> > - * epf_ntb_cmd_handler() - Handle commands provided by the NTB Host
> > + * epf_ntb_cmd_handler() - Handle commands provided by the NTB HOST
> >   * @work: work_struct for the epf_ntb_epc
> >   *
> >   * Workqueue function that gets invoked for the two epf_ntb_epc
> >   * periodically (once every 5ms) to see if it has received any commands
> > - * from NTB host. The host can send commands to configure doorbell or
> > + * from NTB HOST. The HOST can send commands to configure doorbell or
> >   * configure memory window or to update link status.
> >   */
> >  static void epf_ntb_cmd_handler(struct work_struct *work)
> > @@ -254,12 +257,9 @@ static void epf_ntb_cmd_handler(struct work_struct
> > *work)
> >  	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
> > 
> >  	for (i = 1; i < ntb->db_count; i++) {
> > -		if (readl(ntb->epf_db + i * 4)) {
> > -			if (readl(ntb->epf_db + i * 4))
> > -				ntb->db |= 1 << (i - 1);
> > -
> > +		if (ntb->epf_db[i]) {
> >  			ntb_db_event(&ntb->ntb, i);
> > -			writel(0, ntb->epf_db + i * 4);
> > +			ntb->epf_db[i] = 0;
> >  		}
> >  	}
> > 
> > @@ -321,8 +321,8 @@ static void epf_ntb_cmd_handler(struct work_struct
> > *work)
> > 
> >  /**
> >   * epf_ntb_config_sspad_bar_clear() - Clear Config + Self scratchpad BAR
> > - * @ntb_epc: EPC associated with one of the HOST which holds peer's
> > outbound
> > - *	     address.
> > + * @ntb: EPC associated with one of the HOST which holds peer's outbound
> > + *	 address.
> >   *
> >   * Clear BAR0 of EP CONTROLLER 1 which contains the HOST1's config and
> >   * self scratchpad region (removes inbound ATU configuration). While BAR0
> > is
> > @@ -331,8 +331,10 @@ static void epf_ntb_cmd_handler(struct work_struct
> > *work)
> >   * used for self scratchpad from epf_ntb_bar[BAR_CONFIG].
> >   *
> >   * Please note the self scratchpad region and config region is combined to
> > - * a single region and mapped using the same BAR. Also note HOST2's peer
> > - * scratchpad is HOST1's self scratchpad.
> > + * a single region and mapped using the same BAR. Also note VHOST's peer
> > + * scratchpad is HOST's self scratchpad.
> > + *
> > + * Returns: void
> >   */
> >  static void epf_ntb_config_sspad_bar_clear(struct epf_ntb *ntb)
> >  {
> > @@ -347,13 +349,15 @@ static void epf_ntb_config_sspad_bar_clear(struct
> > epf_ntb *ntb)
> > 
> >  /**
> >   * epf_ntb_config_sspad_bar_set() - Set Config + Self scratchpad BAR
> > - * @ntb: NTB device that facilitates communication between HOST and
> > vHOST
> > + * @ntb: NTB device that facilitates communication between HOST and
> > VHOST
> >   *
> > - * Map BAR0 of EP CONTROLLER 1 which contains the HOST1's config and
> > + * Map BAR0 of EP CONTROLLER which contains the VHOST's config and
> >   * self scratchpad region.
> >   *
> >   * Please note the self scratchpad region and config region is combined to
> >   * a single region and mapped using the same BAR.
> > + *
> > + * Returns: Zero for success, or an error code in case of failure
> >   */
> >  static int epf_ntb_config_sspad_bar_set(struct epf_ntb *ntb)
> >  {
> > @@ -380,7 +384,7 @@ static int epf_ntb_config_sspad_bar_set(struct
> > epf_ntb *ntb)
> >  /**
> >   * epf_ntb_config_spad_bar_free() - Free the physical memory associated
> > with
> >   *   config + scratchpad region
> > - * @ntb: NTB device that facilitates communication between HOST and
> > vHOST
> > + * @ntb: NTB device that facilitates communication between HOST and
> > VHOST
> >   */
> >  static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
> >  {
> > @@ -393,11 +397,13 @@ static void epf_ntb_config_spad_bar_free(struct
> > epf_ntb *ntb)
> >  /**
> >   * epf_ntb_config_spad_bar_alloc() - Allocate memory for config +
> > scratchpad
> >   *   region
> > - * @ntb: NTB device that facilitates communication between HOST1 and
> > HOST2
> > + * @ntb: NTB device that facilitates communication between HOST and
> > VHOST
> >   *
> >   * Allocate the Local Memory mentioned in the above diagram. The size of
> >   * CONFIG REGION is sizeof(struct epf_ntb_ctrl) and size of SCRATCHPAD
> > REGION
> >   * is obtained from "spad-count" configfs entry.
> > + *
> > + * Returns: Zero for success, or an error code in case of failure
> >   */
> >  static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
> >  {
> > @@ -424,7 +430,7 @@ static int epf_ntb_config_spad_bar_alloc(struct
> > epf_ntb *ntb)
> >  	spad_count = ntb->spad_count;
> > 
> >  	ctrl_size = sizeof(struct epf_ntb_ctrl);
> > -	spad_size = 2 * spad_count * 4;
> > +	spad_size = 2 * spad_count * sizeof(u32);
> > 
> >  	if (!align) {
> >  		ctrl_size = roundup_pow_of_two(ctrl_size);
> > @@ -454,7 +460,7 @@ static int epf_ntb_config_spad_bar_alloc(struct
> > epf_ntb *ntb)
> >  	ctrl->num_mws = ntb->num_mws;
> >  	ntb->spad_size = spad_size;
> > 
> > -	ctrl->db_entry_size = 4;
> > +	ctrl->db_entry_size = sizeof(u32);
> > 
> >  	for (i = 0; i < ntb->db_count; i++) {
> >  		ntb->reg->db_data[i] = 1 + i;
> > @@ -465,11 +471,13 @@ static int epf_ntb_config_spad_bar_alloc(struct
> > epf_ntb *ntb)
> >  }
> > 
> >  /**
> > - * epf_ntb_configure_interrupt() - Configure MSI/MSI-X capaiblity
> > - * @ntb: NTB device that facilitates communication between HOST and
> > vHOST
> > + * epf_ntb_configure_interrupt() - Configure MSI/MSI-X capability
> > + * @ntb: NTB device that facilitates communication between HOST and
> > VHOST
> >   *
> >   * Configure MSI/MSI-X capability for each interface with number of
> >   * interrupts equal to "db_count" configfs entry.
> > + *
> > + * Returns: Zero for success, or an error code in case of failure
> >   */
> >  static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
> >  {
> > @@ -511,18 +519,22 @@ static int epf_ntb_configure_interrupt(struct
> > epf_ntb *ntb)
> > 
> >  /**
> >   * epf_ntb_db_bar_init() - Configure Doorbell window BARs
> > - * @ntb: NTB device that facilitates communication between HOST and
> > vHOST
> > + * @ntb: NTB device that facilitates communication between HOST and
> > VHOST
> > + *
> > + * Returns: Zero for success, or an error code in case of failure
> >   */
> >  static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
> >  {
> >  	const struct pci_epc_features *epc_features;
> > -	u32 align;
> >  	struct device *dev = &ntb->epf->dev;
> > -	int ret;
> >  	struct pci_epf_bar *epf_bar;
> > -	void __iomem *mw_addr;
> >  	enum pci_barno barno;
> > -	size_t size = 4 * ntb->db_count;
> > +	void *mw_addr;
> > +	size_t size;
> > +	u32 align;
> > +	int ret;
> > +
> > +	size = sizeof(u32) * ntb->db_count;
> > 
> >  	epc_features = pci_epc_get_features(ntb->epf->epc,
> >  					    ntb->epf->func_no,
> > @@ -557,14 +569,14 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
> >  	return ret;
> > 
> >  err_alloc_peer_mem:
> > -	pci_epc_mem_free_addr(ntb->epf->epc, epf_bar->phys_addr,
> > mw_addr, epf_bar->size);
> > +	pci_epf_free_space(ntb->epf, mw_addr, barno, 0);
> >  	return -1;
> >  }
> > 
> >  /**
> >   * epf_ntb_db_bar_clear() - Clear doorbell BAR and free memory
> >   *   allocated in peer's outbound address space
> > - * @ntb: NTB device that facilitates communication between HOST and
> > vHOST
> > + * @ntb: NTB device that facilitates communication between HOST and
> > VHOST
> >   */
> >  static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
> >  {
> > @@ -580,8 +592,9 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
> > 
> >  /**
> >   * epf_ntb_mw_bar_init() - Configure Memory window BARs
> > - * @ntb: NTB device that facilitates communication between HOST and
> > vHOST
> > + * @ntb: NTB device that facilitates communication between HOST and
> > VHOST
> >   *
> > + * Returns: Zero for success, or an error code in case of failure
> >   */
> >  static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
> >  {
> > @@ -629,7 +642,7 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
> > 
> >  /**
> >   * epf_ntb_mw_bar_clear() - Clear Memory window BARs
> > - * @ntb: NTB device that facilitates communication between HOST and
> > vHOST
> > + * @ntb: NTB device that facilitates communication between HOST and
> > VHOST
> >   */
> >  static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb)
> >  {
> > @@ -652,7 +665,7 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb
> > *ntb)
> > 
> >  /**
> >   * epf_ntb_epc_destroy() - Cleanup NTB EPC interface
> > - * @ntb: NTB device that facilitates communication between HOST and
> > vHOST
> > + * @ntb: NTB device that facilitates communication between HOST and
> > VHOST
> >   *
> >   * Wrapper for epf_ntb_epc_destroy_interface() to cleanup all the NTB
> > interfaces
> >   */
> > @@ -665,7 +678,9 @@ static void epf_ntb_epc_destroy(struct epf_ntb *ntb)
> >  /**
> >   * epf_ntb_init_epc_bar() - Identify BARs to be used for each of the NTB
> >   * constructs (scratchpad region, doorbell, memorywindow)
> > - * @ntb: NTB device that facilitates communication between HOST and
> > vHOST
> > + * @ntb: NTB device that facilitates communication between HOST and
> > VHOST
> > + *
> > + * Returns: Zero for success, or an error code in case of failure
> >   */
> >  static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
> >  {
> > @@ -706,11 +721,13 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
> > 
> >  /**
> >   * epf_ntb_epc_init() - Initialize NTB interface
> > - * @ntb: NTB device that facilitates communication between HOST and
> > vHOST2
> > + * @ntb: NTB device that facilitates communication between HOST and
> > VHOST
> >   *
> >   * Wrapper to initialize a particular EPC interface and start the workqueue
> > - * to check for commands from host. This function will write to the
> > + * to check for commands from HOST. This function will write to the
> >   * EP controller HW for configuring it.
> > + *
> > + * Returns: Zero for success, or an error code in case of failure
> >   */
> >  static int epf_ntb_epc_init(struct epf_ntb *ntb)
> >  {
> > @@ -777,7 +794,7 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
> > 
> >  /**
> >   * epf_ntb_epc_cleanup() - Cleanup all NTB interfaces
> > - * @ntb: NTB device that facilitates communication between HOST1 and
> > HOST2
> > + * @ntb: NTB device that facilitates communication between HOST and
> > VHOST
> >   *
> >   * Wrapper to cleanup all NTB interfaces.
> >   */
> > @@ -934,6 +951,8 @@ static const struct config_item_type ntb_group_type
> > = {
> >   *
> >   * Add configfs directory specific to NTB. This directory will hold
> >   * NTB specific properties like db_count, spad_count, num_mws etc.,
> > + *
> > + * Returns: Pointer to config_group
> >   */
> >  static struct config_group *epf_ntb_add_cfs(struct pci_epf *epf,
> >  					    struct config_group *group)
> > @@ -1084,11 +1103,11 @@ static int vntb_epf_link_enable(struct ntb_dev
> > *ntb,
> >  static u32 vntb_epf_spad_read(struct ntb_dev *ndev, int idx)
> >  {
> >  	struct epf_ntb *ntb = ntb_ndev(ndev);
> > -	int off = ntb->reg->spad_offset, ct = ntb->reg->spad_count * 4;
> > +	int off = ntb->reg->spad_offset, ct = ntb->reg->spad_count *
> > sizeof(u32);
> >  	u32 val;
> > -	void __iomem *base = ntb->reg;
> > +	void __iomem *base = (void __iomem *)ntb->reg;
> > 
> > -	val = readl(base + off + ct + idx * 4);
> > +	val = readl(base + off + ct + idx * sizeof(u32));
> >  	return val;
> >  }
> > 
> > @@ -1096,10 +1115,10 @@ static int vntb_epf_spad_write(struct ntb_dev
> > *ndev, int idx, u32 val)
> >  {
> >  	struct epf_ntb *ntb = ntb_ndev(ndev);
> >  	struct epf_ntb_ctrl *ctrl = ntb->reg;
> > -	int off = ctrl->spad_offset, ct = ctrl->spad_count * 4;
> > -	void __iomem *base = ntb->reg;
> > +	int off = ctrl->spad_offset, ct = ctrl->spad_count * sizeof(u32);
> > +	void __iomem *base = (void __iomem *)ntb->reg;
> > 
> > -	writel(val, base + off + ct + idx * 4);
> > +	writel(val, base + off + ct + idx * sizeof(u32));
> >  	return 0;
> >  }
> > 
> > @@ -1108,10 +1127,10 @@ static u32 vntb_epf_peer_spad_read(struct
> > ntb_dev *ndev, int pidx, int idx)
> >  	struct epf_ntb *ntb = ntb_ndev(ndev);
> >  	struct epf_ntb_ctrl *ctrl = ntb->reg;
> >  	int off = ctrl->spad_offset;
> > -	void __iomem *base = ntb->reg;
> > +	void __iomem *base = (void __iomem *)ntb->reg;
> >  	u32 val;
> > 
> > -	val = readl(base + off + idx * 4);
> > +	val = readl(base + off + idx * sizeof(u32));
> >  	return val;
> >  }
> > 
> > @@ -1120,9 +1139,9 @@ static int vntb_epf_peer_spad_write(struct
> > ntb_dev *ndev, int pidx, int idx, u32
> >  	struct epf_ntb *ntb = ntb_ndev(ndev);
> >  	struct epf_ntb_ctrl *ctrl = ntb->reg;
> >  	int off = ctrl->spad_offset;
> > -	void __iomem *base = ntb->reg;
> > +	void __iomem *base = (void __iomem *)ntb->reg;
> > 
> > -	writel(val, base + off + idx * 4);
> > +	writel(val, base + off + idx * sizeof(u32));
> >  	return 0;
> >  }
> > 
> > @@ -1275,6 +1294,8 @@ static struct pci_driver vntb_pci_driver = {
> >   * Invoked when a primary interface or secondary interface is bound to EPC
> >   * device. This function will succeed only when EPC is bound to both the
> >   * interfaces.
> > + *
> > + * Returns: Zero for success, or an error code in case of failure
> >   */
> >  static int epf_ntb_bind(struct pci_epf *epf)
> >  {
> > @@ -1359,6 +1380,8 @@ static struct pci_epf_ops epf_ntb_ops = {
> >   *
> >   * Probe NTB function driver when endpoint function bus detects a NTB
> >   * endpoint function.
> > + *
> > + * Returns: Zero for success, or an error code in case of failure
> >   */
> >  static int epf_ntb_probe(struct pci_epf *epf)
> >  {
> > --
> > 2.35.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
