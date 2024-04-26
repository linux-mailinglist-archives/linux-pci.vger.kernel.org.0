Return-Path: <linux-pci+bounces-6695-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C38778B3C77
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 18:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33E411F229E7
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 16:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E7014F109;
	Fri, 26 Apr 2024 16:12:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27979148FE1;
	Fri, 26 Apr 2024 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147927; cv=none; b=rEBalFM3qtO8nhDj8H+ktwjm1PmaEdmLwSZfgo7qIHPxGcw3pO9yEbFm1A52TRWdtYBfrGHBc5k+DwFhjJj6rXuJ+5oV1uhDYlQ7CYq02gfBS8BOPzDj6chUwzTDmxsGoo8YxNd/Wq5u5w7hc7QCJ1kB3nCj2mNm6mGqL6rSdDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147927; c=relaxed/simple;
	bh=VgzhTmVD5rrpMdVv+Epuseb412iscCiAD5rrfiDFg3E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/kSu3Y5OAKVGH7e+c5eoXVdfStWmHukfJtv5QACl/QopCBvaiXurBwKRy/i+tjrK5ncCf+rZeY60lndNPq/jTnV52dVpbC4C0pOeJy6ObFt4YSt+p5v+o9GmEkk/2GDl47NGWenTY6UWLtPBE5pHLdZmHDROa8+tzk2e2MSYQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VQyNC1Mh5z6K6PC;
	Sat, 27 Apr 2024 00:09:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 36C67140B55;
	Sat, 27 Apr 2024 00:12:00 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 26 Apr
 2024 17:11:59 +0100
Date: Fri, 26 Apr 2024 17:11:58 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"james.morse@arm.com" <james.morse@arm.com>, "Luck, Tony"
	<tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "Jiang, Dave" <dave.jiang@intel.com>, "Schofield,
 Alison" <alison.schofield@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "helgaas@kernel.org"
	<helgaas@kernel.org>, "mahesh@linux.ibm.com" <mahesh@linux.ibm.com>,
	"oohall@gmail.com" <oohall@gmail.com>, "linmiaohe@huawei.com"
	<linmiaohe@huawei.com>, "shiju.jose@huawei.com" <shiju.jose@huawei.com>,
	"Preble, Adam C" <adam.c.preble@intel.com>, "leoyang.li@nxp.com"
	<leoyang.li@nxp.com>, "lukas@wunner.de" <lukas@wunner.de>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "rrichter@amd.com"
	<rrichter@amd.com>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Tsaur, Erwin"
	<erwin.tsaur@intel.com>, "Kuppuswamy, Sathyanarayanan"
	<sathyanarayanan.kuppuswamy@intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "Wanyan, Feiting" <feiting.wanyan@intel.com>,
	"Wang, Yudong" <yudong.wang@intel.com>, "Peng, Chao P"
	<chao.p.peng@intel.com>, "qingshun.wang@linux.intel.com"
	<qingshun.wang@linux.intel.com>
Subject: Re: [PATCH v3 1/3] PCI/AER: Store UNCOR_STATUS bits that might be
 ANFE in aer_err_info
Message-ID: <20240426171158.000024d4@Huawei.com>
In-Reply-To: <SJ0PR11MB6744EC971D1BE6F3119EEA9992112@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240417061407.1491361-1-zhenzhong.duan@intel.com>
	<20240417061407.1491361-2-zhenzhong.duan@intel.com>
	<20240422171629.00005675@Huawei.com>
	<SJ0PR11MB6744EC971D1BE6F3119EEA9992112@SJ0PR11MB6744.namprd11.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 23 Apr 2024 02:25:05 +0000
"Duan, Zhenzhong" <zhenzhong.duan@intel.com> wrote:

> >-----Original Message-----
> >From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> >Subject: Re: [PATCH v3 1/3] PCI/AER: Store UNCOR_STATUS bits that might
> >be ANFE in aer_err_info
> >
> >On Wed, 17 Apr 2024 14:14:05 +0800
> >Zhenzhong Duan <zhenzhong.duan@intel.com> wrote:
> >  
> >> In some cases the detector of a Non-Fatal Error(NFE) is not the most
> >> appropriate agent to determine the type of the error. For example,
> >> when software performs a configuration read from a non-existent
> >> device or Function, completer will send an ERR_NONFATAL Message.
> >> On some platforms, ERR_NONFATAL results in a System Error, which
> >> breaks normal software probing.
> >>
> >> Advisory Non-Fatal Error(ANFE) is a special case that can be used
> >> in above scenario. It is predominantly determined by the role of the
> >> detecting agent (Requester, Completer, or Receiver) and the specific
> >> error. In such cases, an agent with AER signals the NFE (if enabled)
> >> by sending an ERR_COR Message as an advisory to software, instead of
> >> sending ERR_NONFATAL.
> >>
> >> When processing an ANFE, ideally both correctable error(CE) status and
> >> uncorrectable error(UE) status should be cleared. However, there is no
> >> way to fully identify the UE associated with ANFE. Even worse, a Fatal
> >> Error(FE) or Non-Fatal Error(NFE) may set the same UE status bit as
> >> ANFE. Treating an ANFE as NFE will reproduce above mentioned issue,
> >> i.e., breaking softwore probing; treating NFE as ANFE will make us
> >> ignoring some UEs which need active recover operation. To avoid clearing
> >> UEs that are not ANFE by accident, the most conservative route is taken
> >> here: If any of the FE/NFE Detected bits is set in Device Status, do not
> >> touch UE status, they should be cleared later by the UE handler. Otherwise,
> >> a specific set of UEs that may be raised as ANFE according to the PCIe
> >> specification will be cleared if their corresponding severity is Non-Fatal.
> >>
> >> To achieve above purpose, store UNCOR_STATUS bits that might be ANFE
> >> in aer_err_info.anfe_status. So that those bits could be printed and
> >> processed later.
> >>
> >> Tested-by: Yudong Wang <yudong.wang@intel.com>
> >> Co-developed-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
> >> Signed-off-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
> >> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> >> ---
> >>  drivers/pci/pci.h      |  1 +
> >>  drivers/pci/pcie/aer.c | 45  
> >++++++++++++++++++++++++++++++++++++++++++  
> >>  2 files changed, 46 insertions(+)
> >>
> >> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> >> index 17fed1846847..3f9eb807f9fd 100644
> >> --- a/drivers/pci/pci.h
> >> +++ b/drivers/pci/pci.h
> >> @@ -412,6 +412,7 @@ struct aer_err_info {
> >>
> >>  	unsigned int status;		/* COR/UNCOR Error Status */
> >>  	unsigned int mask;		/* COR/UNCOR Error Mask */
> >> +	unsigned int anfe_status;	/* UNCOR Error Status for ANFE */
> >>  	struct pcie_tlp_log tlp;	/* TLP Header */
> >>  };
> >>
> >> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> >> index ac6293c24976..27364ab4b148 100644
> >> --- a/drivers/pci/pcie/aer.c
> >> +++ b/drivers/pci/pcie/aer.c
> >> @@ -107,6 +107,12 @@ struct aer_stats {
> >>  					PCI_ERR_ROOT_MULTI_COR_RCV |  
> >	\  
> >>  					PCI_ERR_ROOT_MULTI_UNCOR_RCV)
> >>
> >> +#define AER_ERR_ANFE_UNC_MASK  
> >	(PCI_ERR_UNC_POISON_TLP |	\  
> >> +					PCI_ERR_UNC_COMP_TIME |  
> >	\  
> >> +					PCI_ERR_UNC_COMP_ABORT |  
> >	\  
> >> +					PCI_ERR_UNC_UNX_COMP |  
> >	\  
> >> +					PCI_ERR_UNC_UNSUP)
> >> +
> >>  static int pcie_aer_disable;
> >>  static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
> >>
> >> @@ -1196,6 +1202,41 @@ void aer_recover_queue(int domain, unsigned  
> >int bus, unsigned int devfn,  
> >>  EXPORT_SYMBOL_GPL(aer_recover_queue);
> >>  #endif
> >>
> >> +static void anfe_get_uc_status(struct pci_dev *dev, struct aer_err_info  
> >*info)  
> >> +{
> >> +	u32 uncor_mask, uncor_status;
> >> +	u16 device_status;
> >> +	int aer = dev->aer_cap;
> >> +
> >> +	if (pcie_capability_read_word(dev, PCI_EXP_DEVSTA,  
> >&device_status))  
> >> +		return;
> >> +	/*
> >> +	 * Take the most conservative route here. If there are
> >> +	 * Non-Fatal/Fatal errors detected, do not assume any
> >> +	 * bit in uncor_status is set by ANFE.
> >> +	 */
> >> +	if (device_status & (PCI_EXP_DEVSTA_NFED | PCI_EXP_DEVSTA_FED))
> >> +		return;
> >> +  
> >
> >Is there not a race here?  If we happen to get either an NFED or FED
> >between the read of device_status above and here we might pick up a status
> >that corresponds to that (and hence clear something we should not).  
> 
> In this scenario, info->anfe_status is 0.

OK. In that case what is the point of the check above?
If the code is safe to races, it's safe to go ahead without that check
on what might race.

> 
> >
> >Or am I missing that race being close somewhere?  
> 
> The bits leading to NFED or FED is masked out when assigning info->anfe_status.
> Bits for FED is masked out by ~info->severity,
> bit for NFED is masked out by AER_ERR_ANFE_UNC_MASK.
> 
> So we never clear status bits for NFED or FED in ANFE handler.
> 
> See below assignment of info->anfe_status.
> 
> Thanks
> Zhenzhong
> 
> >  
> >> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS,  
> >&uncor_status);  
> >> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK,  
> >&uncor_mask);  
> >> +	/*
> >> +	 * According to PCIe Base Specification Revision 6.1,
> >> +	 * Section 6.2.3.2.4, if an UNCOR error is raised as
> >> +	 * Advisory Non-Fatal error, it will match the following
> >> +	 * conditions:
> >> +	 *	a. The severity of the error is Non-Fatal.
> >> +	 *	b. The error is one of the following:
> >> +	 *		1. Poisoned TLP           (Section 6.2.3.2.4.3)
> >> +	 *		2. Completion Timeout     (Section 6.2.3.2.4.4)
> >> +	 *		3. Completer Abort        (Section 6.2.3.2.4.1)
> >> +	 *		4. Unexpected Completion  (Section 6.2.3.2.4.5)
> >> +	 *		5. Unsupported Request    (Section 6.2.3.2.4.1)
> >> +	 */
> >> +	info->anfe_status = uncor_status & ~uncor_mask & ~info->severity  
> >&  
> >> +			    AER_ERR_ANFE_UNC_MASK;
> >> +}
> >> +
> >>  /**
> >>   * aer_get_device_error_info - read error status from dev and store it to  
> >info  
> >>   * @dev: pointer to the device expected to have a error record
> >> @@ -1213,6 +1254,7 @@ int aer_get_device_error_info(struct pci_dev  
> >*dev, struct aer_err_info *info)  
> >>
> >>  	/* Must reset in this function */
> >>  	info->status = 0;
> >> +	info->anfe_status = 0;
> >>  	info->tlp_header_valid = 0;
> >>
> >>  	/* The device might not support AER */
> >> @@ -1226,6 +1268,9 @@ int aer_get_device_error_info(struct pci_dev  
> >*dev, struct aer_err_info *info)  
> >>  			&info->mask);
> >>  		if (!(info->status & ~info->mask))
> >>  			return 0;
> >> +
> >> +		if (info->status & PCI_ERR_COR_ADV_NFAT)
> >> +			anfe_get_uc_status(dev, info);
> >>  	} else if (type == PCI_EXP_TYPE_ROOT_PORT ||
> >>  		   type == PCI_EXP_TYPE_RC_EC ||
> >>  		   type == PCI_EXP_TYPE_DOWNSTREAM ||  
> 
> 


