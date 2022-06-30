Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597AE561ABB
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jun 2022 14:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbiF3MtU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jun 2022 08:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbiF3MtS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2022 08:49:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BABB3FD9D;
        Thu, 30 Jun 2022 05:49:17 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UCNHVO021290;
        Thu, 30 Jun 2022 12:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=z82onWhMH2MeNyfwc0u66x2ucSnI99TbyunPSGwrsdI=;
 b=OR3KXOn+/968sEfA9DIFSLxLoFGYsrakgpKMeJCBt5ixGiN9tGnLO3ze5mr1vFarF1bU
 yw0ywSC5WI6mHtvo0Pov/P3bYXHTV9G1E/6yc/VplFzknxmqcdmKVlWETvl4WuHmiquC
 bmaVQJL4n3eATPSFPwDgO/szBXriu1E1+B2cvIqkb5stZr0fZi2RSODYyckDpDYC6CZk
 qyK8w4GksmMS73tT6hW0ybJQ490pvgUIFiebXgVEQgmOK7ss/oqO29pgMG3ly9h967Xp
 d+LsGFSaC8B+sUgUpa7nPi/AZkcbp15j1/f60RlYqfUXZFVjexohnkB8p/ktU6PKu1Mm Kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1bsn0jqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 12:49:14 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25UCav0I007066;
        Thu, 30 Jun 2022 12:49:14 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1bsn0jpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 12:49:14 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25UCd7Ig023320;
        Thu, 30 Jun 2022 12:49:12 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3gwt09046w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 12:49:11 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25UCn8QT17694980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 12:49:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B52755204E;
        Thu, 30 Jun 2022 12:49:08 +0000 (GMT)
Received: from [9.171.69.2] (unknown [9.171.69.2])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4FFA352050;
        Thu, 30 Jun 2022 12:49:08 +0000 (GMT)
Message-ID: <54426ccd-8c1d-c4e5-6fec-07c77c0f3d59@linux.ibm.com>
Date:   Thu, 30 Jun 2022 14:53:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v6 5/5] s390/pci: allow zPCI zbus without a function zero
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220628143100.3228092-1-schnelle@linux.ibm.com>
 <20220628143100.3228092-6-schnelle@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
In-Reply-To: <20220628143100.3228092-6-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: s4_fxW1o1PXuqSjfHBSRDmuuGzXdE0vP
X-Proofpoint-GUID: uVzBkvkvE5Cixpdp_DbF1bgW1waVTp2K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_07,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206300050
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/28/22 16:31, Niklas Schnelle wrote:
> Currently the zPCI code block PCI bus creation and probing of a zPCI
> zbus unless there is a PCI function with devfn 0. This is always the
> case for the PCI functions with hidden RID but may keep PCI functions
> from a multi-function PCI device with RID information invisible until
> the function 0 becomes visible. Worse as a PCI bus is necessary to even
> present a PCI hotplug slot even that remains invisible.
> 
> With the probing of these so called isolated PCI functions enabled for
> s390 in common code this restriction is no longer necessary. On network
> cards with multiple ports and a PF per port this also allows using each
> port on its own while still providing the physical PCI topology
> information in the devfn needed to associate VFs with their parent PF.
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>   arch/s390/pci/pci_bus.c | 82 ++++++++++-------------------------------
>   1 file changed, 20 insertions(+), 62 deletions(-)
> 
> diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
> index 5d77acbd1c87..6a8da1b742ae 100644
> --- a/arch/s390/pci/pci_bus.c
> +++ b/arch/s390/pci/pci_bus.c
> @@ -145,9 +145,6 @@ int zpci_bus_scan_bus(struct zpci_bus *zbus)
>   	struct zpci_dev *zdev;
>   	int devfn, rc, ret = 0;
>   
> -	if (!zbus->function[0])
> -		return 0;
> -
>   	for (devfn = 0; devfn < ZPCI_FUNCTIONS_PER_BUS; devfn++) {
>   		zdev = zbus->function[devfn];
>   		if (zdev && zdev->state == ZPCI_FN_STATE_CONFIGURED) {
> @@ -184,26 +181,26 @@ void zpci_bus_scan_busses(void)
>   
>   /* zpci_bus_create_pci_bus - Create the PCI bus associated with this zbus
>    * @zbus: the zbus holding the zdevices
> - * @f0: function 0 of the bus
> + * @fr: PCI root function that will determine the bus's domain, and bus speeed
>    * @ops: the pci operations
>    *
> - * Function zero is taken as a parameter as this is used to determine the
> - * domain, multifunction property and maximum bus speed of the entire bus.
> + * The PCI function @fr determines the domain (its UID), multifunction property
> + * and maximum bus speed of the entire bus.
>    *
>    * Return: 0 on success, an error code otherwise
>    */
> -static int zpci_bus_create_pci_bus(struct zpci_bus *zbus, struct zpci_dev *f0, struct pci_ops *ops)
> +static int zpci_bus_create_pci_bus(struct zpci_bus *zbus, struct zpci_dev *fr, struct pci_ops *ops)
>   {
>   	struct pci_bus *bus;
>   	int domain;
>   
> -	domain = zpci_alloc_domain((u16)f0->uid);
> +	domain = zpci_alloc_domain((u16)fr->uid);
>   	if (domain < 0)
>   		return domain;
>   
>   	zbus->domain_nr = domain;
> -	zbus->multifunction = f0->rid_available;
> -	zbus->max_bus_speed = f0->max_bus_speed;
> +	zbus->multifunction = fr->rid_available;
> +	zbus->max_bus_speed = fr->max_bus_speed;
>   
>   	/*
>   	 * Note that the zbus->resources are taken over and zbus->resources
> @@ -303,47 +300,6 @@ void pcibios_bus_add_device(struct pci_dev *pdev)
>   	}
>   }
>   
> -/* zpci_bus_create_hotplug_slots - Add hotplug slot(s) for device added to bus
> - * @zdev: the zPCI device that was newly added
> - *
> - * Add the hotplug slot(s) for the newly added PCI function. Normally this is
> - * simply the slot for the function itself. If however we are adding the
> - * function 0 on a zbus, it might be that we already registered functions on
> - * that zbus but could not create their hotplug slots yet so add those now too.
> - *
> - * Return: 0 on success, an error code otherwise
> - */
> -static int zpci_bus_create_hotplug_slots(struct zpci_dev *zdev)
> -{
> -	struct zpci_bus *zbus = zdev->zbus;
> -	int devfn, rc = 0;
> -
> -	rc = zpci_init_slot(zdev);
> -	if (rc)
> -		return rc;
> -	zdev->has_hp_slot = 1;
> -
> -	if (zdev->devfn == 0 && zbus->multifunction) {
> -		/* Now that function 0 is there we can finally create the
> -		 * hotplug slots for those functions with devfn != 0 that have
> -		 * been parked in zbus->function[] waiting for us to be able to
> -		 * create the PCI bus.
> -		 */
> -		for  (devfn = 1; devfn < ZPCI_FUNCTIONS_PER_BUS; devfn++) {
> -			zdev = zbus->function[devfn];
> -			if (zdev && !zdev->has_hp_slot) {
> -				rc = zpci_init_slot(zdev);
> -				if (rc)
> -					return rc;
> -				zdev->has_hp_slot = 1;
> -			}
> -		}
> -
> -	}
> -
> -	return rc;
> -}
> -
>   static int zpci_bus_add_device(struct zpci_bus *zbus, struct zpci_dev *zdev)
>   {
>   	int rc = -EINVAL;
> @@ -352,21 +308,19 @@ static int zpci_bus_add_device(struct zpci_bus *zbus, struct zpci_dev *zdev)
>   		pr_err("devfn %04x is already assigned\n", zdev->devfn);
>   		return rc;
>   	}
> +

Unnecessary CR

>   	zdev->zbus = zbus;
>   	zbus->function[zdev->devfn] = zdev;
>   	zpci_nb_devices++;
>   
> -	if (zbus->bus) {
> -		if (zbus->multifunction && !zdev->rid_available) {
> -			WARN_ONCE(1, "rid_available not set for multifunction\n");
> -			goto error;
> -		}
> -
> -		zpci_bus_create_hotplug_slots(zdev);
> -	} else {
> -		/* Hotplug slot will be created once function 0 appears */
> -		zbus->multifunction = 1;
> +	if (zbus->multifunction && !zdev->rid_available) {
> +		WARN_ONCE(1, "rid_available not set for multifunction\n");
> +		goto error;
>   	}
> +	rc = zpci_init_slot(zdev);
> +	if (rc)
> +		goto error;
> +	zdev->has_hp_slot = 1;
>   
>   	return 0;
>   
> @@ -400,7 +354,11 @@ int zpci_bus_device_register(struct zpci_dev *zdev, struct pci_ops *ops)
>   			return -ENOMEM;
>   	}
>   
> -	if (zdev->devfn == 0) {
> +	if (!zbus->bus) {
> +		/* The UID of the first PCI function registered with a zpci_bus
> +		 * is used as the domain number for that bus. Currently there
> +		 * is exactly one zpci_bus per domain.
> +		 */
>   		rc = zpci_bus_create_pci_bus(zbus, zdev, ops);
>   		if (rc)
>   			goto error;
> 


Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>


-- 
Pierre Morel
IBM Lab Boeblingen
