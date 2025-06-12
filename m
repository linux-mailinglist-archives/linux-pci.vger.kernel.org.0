Return-Path: <linux-pci+bounces-29535-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E57AD6EC8
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 13:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BADF3A42EC
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 11:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51E522F76C;
	Thu, 12 Jun 2025 11:17:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F03521B9C8;
	Thu, 12 Jun 2025 11:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749727032; cv=none; b=GftkgL6qPyfxAvNCU3+1CNAT+HFObUvufs2a4ED+V2oLS/DVTkeHg/r74/B5aMHAiKY/3XBbRqmlyrEXlO1eB6RhW5+YrCtkDcBieh2ES3uIU7/I9IigJVUqcHDsmbRv15EK7jKU5kx/BnlaMG6wkP/XagMUtGvuhCou1VqynYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749727032; c=relaxed/simple;
	bh=TFCEWGXvntFPe/e4vYhFd6abgsvOKJWrNnZ+Docwxy8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCINxE9Q++/EkqcanVaRC0O1ac0yHCY9nITxzcVX0IGfi9qc888qRXQO77VuTSmuazjIAtj6x4cDLslYwNTbkLJTQHq9hZhN+6isilVGD+IMcOJhN+l0dcA6kc6NuM8SjDz6V/h7CC9LzDAPNYb4Xj7340KzkQ1h81hU9m4RMSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJ0LR4s5qz6HJkn;
	Thu, 12 Jun 2025 19:15:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E348814020C;
	Thu, 12 Jun 2025 19:17:06 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Jun
 2025 13:17:06 +0200
Date: Thu, 12 Jun 2025 12:17:04 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: "Bowman, Terry" <terry.bowman@amd.com>,
	<PradeepVineshReddy.Kodamati@amd.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <bhelgaas@google.com>,
	<bp@alien8.de>, <ming.li@zohomail.com>, <shiju.jose@huawei.com>,
	<dan.carpenter@linaro.org>, <Smita.KoralahalliChannabasappa@amd.com>,
	<kobayashi.da-06@fujitsu.com>, <rrichter@amd.com>, <peterz@infradead.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v9 04/16] PCI/AER: Dequeue forwarded CXL error
Message-ID: <20250612121704.0000498e@huawei.com>
In-Reply-To: <bd4a48f0-c3b2-407f-914c-74c0f062970b@intel.com>
References: <20250603172239.159260-1-terry.bowman@amd.com>
	<20250603172239.159260-5-terry.bowman@amd.com>
	<81214183-fd94-428b-abeb-3ec3d2688030@intel.com>
	<c013da01-dc6b-470f-9dbb-e209e293763a@amd.com>
	<180a024d-9f93-4439-b25c-808a22665d2a@intel.com>
	<d20d801a-49e5-4b78-bc1c-57f232ebd560@amd.com>
	<bd4a48f0-c3b2-407f-914c-74c0f062970b@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 9 Jun 2025 13:34:31 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 6/9/25 12:57 PM, Bowman, Terry wrote:
> >=20
> >=20
> > On 6/6/2025 5:43 PM, Dave Jiang wrote: =20
> >>
> >> On 6/6/25 11:14 AM, Bowman, Terry wrote: =20
> >>>
> >>> On 6/6/2025 10:57 AM, Dave Jiang wrote: =20
> >>>> On 6/3/25 10:22 AM, Terry Bowman wrote: =20
> >>>>> The AER driver is now designed to forward CXL protocol errors to th=
e CXL
> >>>>> driver. Update the CXL driver with functionality to dequeue the for=
warded
> >>>>> CXL error from the kfifo. Also, update the CXL driver to begin the =
protocol
> >>>>> error handling processing using the work received from the FIFO.
> >>>>>
> >>>>> Introduce function cxl_prot_err_work_fn() to dequeue work forwarded=
 by the
> >>>>> AER service driver. This will begin the CXL protocol error processi=
ng
> >>>>> with a call to cxl_handle_prot_error().
> >>>>>
> >>>>> Update cxl/core/ras.c by adding cxl_rch_handle_error_iter() that was
> >>>>> previously in the AER driver.
> >>>>>
> >>>>> Introduce sbdf_to_pci() to take the SBDF values from 'struct cxl_pr=
ot_error_info'
> >>>>> and use in discovering the erring PCI device. Make scope based refe=
rence
> >>>>> increments/decrements for the discovered PCI device and the associa=
ted
> >>>>> CXL device.
> >>>>>
> >>>>> Implement cxl_handle_prot_error() to differentiate between Restrict=
ed CXL
> >>>>> Host (RCH) protocol errors and CXL virtual host (VH) protocol error=
s.
> >>>>> RCH errors will be processed with a call to walk the associated Root
> >>>>> Complex Event Collector's (RCEC) secondary bus looking for the Root=
 Complex
> >>>>> Integrated Endpoint (RCiEP) to handle the RCH error. Export pcie_wa=
lk_rcec()
> >>>>> so the CXL driver can walk the RCEC's downstream bus, searching for
> >>>>> the RCiEP.
> >>>>>
> >>>>> VH correctable error (CE) processing will call the CXL CE handler. =
VH
> >>>>> uncorrectable errors (UCE) will call cxl_do_recovery(), implemented=
 as a
> >>>>> stub for now and to be updated in future patch. Export pci_aer_clea=
n_fatal_status()
> >>>>> and pci_clean_device_status() used to clean up AER status after han=
dling.
> >>>>>
> >>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> >>>>> ---
> >>>>>  drivers/cxl/core/ras.c  | 92 +++++++++++++++++++++++++++++++++++++=
++++
> >>>>>  drivers/pci/pci.c       |  1 +
> >>>>>  drivers/pci/pci.h       |  8 ----
> >>>>>  drivers/pci/pcie/aer.c  |  1 +
> >>>>>  drivers/pci/pcie/rcec.c |  1 +
> >>>>>  include/linux/aer.h     |  2 +
> >>>>>  include/linux/pci.h     | 10 +++++
> >>>>>  7 files changed, 107 insertions(+), 8 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> >>>>> index d35525e79e04..9ed5c682e128 100644
> >>>>> --- a/drivers/cxl/core/ras.c
> >>>>> +++ b/drivers/cxl/core/ras.c
> >>>>> @@ -110,8 +110,100 @@ static DECLARE_WORK(cxl_cper_prot_err_work, c=
xl_cper_prot_err_work_fn);
> >>>>> =20
> >>>>>  #ifdef CONFIG_PCIEAER_CXL
> >>>>> =20
> >>>>> +static void cxl_do_recovery(struct pci_dev *pdev)
> >>>>> +{
> >>>>> +}
> >>>>> +
> >>>>> +static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *d=
ata)
> >>>>> +{
> >>>>> +	struct cxl_prot_error_info *err_info =3D data;
> >>>>> +	struct pci_dev *pdev_ref __free(pci_dev_put) =3D pci_dev_get(pdev=
);
> >>>>> +	struct cxl_dev_state *cxlds;
> >>>>> +
> >>>>> +	/*
> >>>>> +	 * The capability, status, and control fields in Device 0,
> >>>>> +	 * Function 0 DVSEC control the CXL functionality of the
> >>>>> +	 * entire device (CXL 3.0, 8.1.3).
> >>>>> +	 */
> >>>>> +	if (pdev->devfn !=3D PCI_DEVFN(0, 0))
> >>>>> +		return 0;
> >>>>> +
> >>>>> +	/*
> >>>>> +	 * CXL Memory Devices must have the 502h class code set (CXL
> >>>>> +	 * 3.0, 8.1.12.1).
> >>>>> +	 */
> >>>>> +	if ((pdev->class >> 8) !=3D PCI_CLASS_MEMORY_CXL) =20
> >>>> Should use FIELD_GET() to be consistent with the rest of CXL code ba=
se =20
> >>> Ok. =20
> >=20
> > Hi Dave,
> >=20
> > I have a question. I found I need to do the same you recommended for is=
_cxl_mem_dev() in
> > drivers/pci/pcie/cxl_aer.c. Looks like I need to define:
> >=20
> > #define PCI_CLASS_CODE_MASK=A0=A0=A0=A0=A0=A0=A0=A0 GENMASK(23, 8)
> >=20
> > to be used as:
> >=20
> > FIELD_GET(PCI_CLASS_CODE_MASK, pdev->class)
> >=20
> > What header file can I add the PCI_CLASS_CODE_MASK #define so that it c=
an be used in CXL
> > and PCI drivers? =20
>=20
> Perhaps include/uapi/linux/pci_regs.h? Although you may need to define th=
e raw mask instead of using GENMASK due to the header being exported to use=
r as well.
>=20
It's messy because that register has 3 fields (at least it does by 6.2 - no=
t sure about earlier)
and we are matching on combination of "sub class code" and "base class code=
" but not the programming
interface which is the bottom 8 bits.

Whilst I'd kind like this cleaned up naming a mask might be a pain...
Maybe we can get away with PCI_CLASS_CODE_MASK given how we name the=20
specific IDs but perhaps making it kernel internal via include/linux/pci_id=
s.h
is safer than an include in uapi?

I'd also like to see such a macro used through out the kernel and not
just in this one place.

Jonathan

> DJ
>=20
> >=20
> > Terry
> >=20
> >  =20
> >>>>> +		return 0;
> >>>>> +
> >>>>> +	if (!is_cxl_memdev(&pdev->dev) || !pdev->dev.driver) =20
> >>>> I think you need to hold the pdev->dev lock while checking if the dr=
iver exists. =20
> >>> Ok. =20
> >>>>> +		return 0;
> >>>>> +
> >>>>> +	cxlds =3D pci_get_drvdata(pdev);
> >>>>> +	struct device *dev __free(put_device) =3D get_device(&cxlds->cxlm=
d->dev); =20
> >>>> Maybe a comment on why cxlmd->dev ref is needed here. =20
> >>> Good point. =20
> >>>>> +
> >>>>> +	if (err_info->severity =3D=3D AER_CORRECTABLE)
> >>>>> +		cxl_cor_error_detected(pdev);
> >>>>> +	else
> >>>>> +		cxl_do_recovery(pdev);
> >>>>> +
> >>>>> +	return 1;
> >>>>> +}
> >>>>> +
> >>>>> +static struct pci_dev *sbdf_to_pci(struct cxl_prot_error_info *err=
_info)
> >>>>> +{
> >>>>> +	unsigned int devfn =3D PCI_DEVFN(err_info->device,
> >>>>> +				       err_info->function);
> >>>>> +	struct pci_dev *pdev __free(pci_dev_put) =3D
> >>>>> +		pci_get_domain_bus_and_slot(err_info->segment,
> >>>>> +					    err_info->bus,
> >>>>> +					    devfn); =20
> >>>> Looks like DanC already caught that. Maybe have this function return=
 with a ref held. I would also add a comment for the function mention that =
the caller need to put the device. =20
> >>> Right. I made the change in v10 source after DanC commented. I'll add=
 a comment that callers must decrement the reference count.. =20
> >>>>> +	return pdev;
> >>>>> +}
> >>>>> +
> >>>>> +static void cxl_handle_prot_error(struct cxl_prot_error_info *err_=
info)
> >>>>> +{
> >>>>> +	struct pci_dev *pdev __free(pci_dev_put) =3D pci_dev_get(sbdf_to_=
pci(err_info));
> >>>>> +
> >>>>> +	if (!pdev) {
> >>>>> +		pr_err("Failed to find the CXL device\n");
> >>>>> +		return;
> >>>>> +	}
> >>>>> +
> >>>>> +	/*
> >>>>> +	 * Internal errors of an RCEC indicate an AER error in an
> >>>>> +	 * RCH's downstream port. Check and handle them in the CXL.mem
> >>>>> +	 * device driver.
> >>>>> +	 */
> >>>>> +	if (pci_pcie_type(pdev) =3D=3D PCI_EXP_TYPE_RC_EC)
> >>>>> +		return pcie_walk_rcec(pdev, cxl_rch_handle_error_iter, err_info);
> >>>>> + =20
> >>>> cxl_rch_handle_error_iter() holds the pdev device lock when handling=
 errors. Does the code block below need locking?
> >>>>
> >>>> DJ =20
> >>> There is a guard_lock() in the EP CXL error handlers (cxl_error_detec=
ted()/cxl_cor_error_detected()). I have question about
> >>> the same for the non-EP handlers added later: should we add the same =
guard() for the CXL port handlers? That is in following patch:
> >>> [PATCH v9 13/16] cxl/pci: Introduce CXL Port protocol error handlers.=
 =20
> >> I would think so....
> >>
> >> DJ
> >> =20
> >>> Terry =20
> >>>>> +	if (err_info->severity =3D=3D AER_CORRECTABLE) {
> >>>>> +		int aer =3D pdev->aer_cap;
> >>>>> +		struct cxl_dev_state *cxlds =3D pci_get_drvdata(pdev);
> >>>>> +		struct device *dev __free(put_device) =3D get_device(&cxlds->cxl=
md->dev);
> >>>>> +
> >>>>> +		if (aer)
> >>>>> +			pci_clear_and_set_config_dword(pdev,
> >>>>> +						       aer + PCI_ERR_COR_STATUS,
> >>>>> +						       0, PCI_ERR_COR_INTERNAL);
> >>>>> +
> >>>>> +		cxl_cor_error_detected(pdev);
> >>>>> +
> >>>>> +		pcie_clear_device_status(pdev);
> >>>>> +	} else {
> >>>>> +		cxl_do_recovery(pdev);
> >>>>> +	}
> >>>>> +}
> >>>>> +
> >>>>>  static void cxl_prot_err_work_fn(struct work_struct *work)
> >>>>>  {
> >>>>> +	struct cxl_prot_err_work_data wd;
> >>>>> +
> >>>>> +	while (cxl_prot_err_kfifo_get(&wd)) {
> >>>>> +		struct cxl_prot_error_info *err_info =3D &wd.err_info;
> >>>>> +
> >>>>> +		cxl_handle_prot_error(err_info);
> >>>>> +	}
> >>>>>  }
> >>>>> =20
> >>>>>  #else
> >>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >>>>> index e77d5b53c0ce..524ac32b744a 100644
> >>>>> --- a/drivers/pci/pci.c
> >>>>> +++ b/drivers/pci/pci.c
> >>>>> @@ -2328,6 +2328,7 @@ void pcie_clear_device_status(struct pci_dev =
*dev)
> >>>>>  	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
> >>>>>  	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
> >>>>>  }
> >>>>> +EXPORT_SYMBOL_NS_GPL(pcie_clear_device_status, "CXL");
> >>>>>  #endif
> >>>>> =20
> >>>>>  /**
> >>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> >>>>> index d6296500b004..3c54a5ed803e 100644
> >>>>> --- a/drivers/pci/pci.h
> >>>>> +++ b/drivers/pci/pci.h
> >>>>> @@ -649,16 +649,10 @@ static inline bool pci_dpc_recovered(struct p=
ci_dev *pdev) { return false; }
> >>>>>  void pci_rcec_init(struct pci_dev *dev);
> >>>>>  void pci_rcec_exit(struct pci_dev *dev);
> >>>>>  void pcie_link_rcec(struct pci_dev *rcec);
> >>>>> -void pcie_walk_rcec(struct pci_dev *rcec,
> >>>>> -		    int (*cb)(struct pci_dev *, void *),
> >>>>> -		    void *userdata);
> >>>>>  #else
> >>>>>  static inline void pci_rcec_init(struct pci_dev *dev) { }
> >>>>>  static inline void pci_rcec_exit(struct pci_dev *dev) { }
> >>>>>  static inline void pcie_link_rcec(struct pci_dev *rcec) { }
> >>>>> -static inline void pcie_walk_rcec(struct pci_dev *rcec,
> >>>>> -				  int (*cb)(struct pci_dev *, void *),
> >>>>> -				  void *userdata) { }
> >>>>>  #endif
> >>>>> =20
> >>>>>  #ifdef CONFIG_PCI_ATS
> >>>>> @@ -967,7 +961,6 @@ void pci_no_aer(void);
> >>>>>  void pci_aer_init(struct pci_dev *dev);
> >>>>>  void pci_aer_exit(struct pci_dev *dev);
> >>>>>  extern const struct attribute_group aer_stats_attr_group;
> >>>>> -void pci_aer_clear_fatal_status(struct pci_dev *dev);
> >>>>>  int pci_aer_clear_status(struct pci_dev *dev);
> >>>>>  int pci_aer_raw_clear_status(struct pci_dev *dev);
> >>>>>  void pci_save_aer_state(struct pci_dev *dev);
> >>>>> @@ -976,7 +969,6 @@ void pci_restore_aer_state(struct pci_dev *dev);
> >>>>>  static inline void pci_no_aer(void) { }
> >>>>>  static inline void pci_aer_init(struct pci_dev *d) { }
> >>>>>  static inline void pci_aer_exit(struct pci_dev *d) { }
> >>>>> -static inline void pci_aer_clear_fatal_status(struct pci_dev *dev)=
 { }
> >>>>>  static inline int pci_aer_clear_status(struct pci_dev *dev) { retu=
rn -EINVAL; }
> >>>>>  static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { =
return -EINVAL; }
> >>>>>  static inline void pci_save_aer_state(struct pci_dev *dev) { }
> >>>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> >>>>> index 5350fa5be784..6e88331c6303 100644
> >>>>> --- a/drivers/pci/pcie/aer.c
> >>>>> +++ b/drivers/pci/pcie/aer.c
> >>>>> @@ -290,6 +290,7 @@ void pci_aer_clear_fatal_status(struct pci_dev =
*dev)
> >>>>>  	if (status)
> >>>>>  		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
> >>>>>  }
> >>>>> +EXPORT_SYMBOL_GPL(pci_aer_clear_fatal_status);
> >>>>> =20
> >>>>>  /**
> >>>>>   * pci_aer_raw_clear_status - Clear AER error registers.
> >>>>> diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
> >>>>> index d0bcd141ac9c..fb6cf6449a1d 100644
> >>>>> --- a/drivers/pci/pcie/rcec.c
> >>>>> +++ b/drivers/pci/pcie/rcec.c
> >>>>> @@ -145,6 +145,7 @@ void pcie_walk_rcec(struct pci_dev *rcec, int (=
*cb)(struct pci_dev *, void *),
> >>>>> =20
> >>>>>  	walk_rcec(walk_rcec_helper, &rcec_data);
> >>>>>  }
> >>>>> +EXPORT_SYMBOL_NS_GPL(pcie_walk_rcec, "CXL");
> >>>>> =20
> >>>>>  void pci_rcec_init(struct pci_dev *dev)
> >>>>>  {
> >>>>> diff --git a/include/linux/aer.h b/include/linux/aer.h
> >>>>> index 550407240ab5..c9a18eca16f8 100644
> >>>>> --- a/include/linux/aer.h
> >>>>> +++ b/include/linux/aer.h
> >>>>> @@ -77,12 +77,14 @@ struct cxl_prot_err_work_data {
> >>>>> =20
> >>>>>  #if defined(CONFIG_PCIEAER)
> >>>>>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
> >>>>> +void pci_aer_clear_fatal_status(struct pci_dev *dev);
> >>>>>  int pcie_aer_is_native(struct pci_dev *dev);
> >>>>>  #else
> >>>>>  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *de=
v)
> >>>>>  {
> >>>>>  	return -EINVAL;
> >>>>>  }
> >>>>> +static inline void pci_aer_clear_fatal_status(struct pci_dev *dev)=
 { }
> >>>>>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return=
 0; }
> >>>>>  #endif
> >>>>> =20
> >>>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
> >>>>> index bff3009f9ff0..cd53715d53f3 100644
> >>>>> --- a/include/linux/pci.h
> >>>>> +++ b/include/linux/pci.h
> >>>>> @@ -1806,6 +1806,9 @@ extern bool pcie_ports_native;
> >>>>> =20
> >>>>>  int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed=
 speed_req,
> >>>>>  			  bool use_lt);
> >>>>> +void pcie_walk_rcec(struct pci_dev *rcec,
> >>>>> +		    int (*cb)(struct pci_dev *, void *),
> >>>>> +		    void *userdata);
> >>>>>  #else
> >>>>>  #define pcie_ports_disabled	true
> >>>>>  #define pcie_ports_native	false
> >>>>> @@ -1816,8 +1819,15 @@ static inline int pcie_set_target_speed(stru=
ct pci_dev *port,
> >>>>>  {
> >>>>>  	return -EOPNOTSUPP;
> >>>>>  }
> >>>>> +
> >>>>> +static inline void pcie_walk_rcec(struct pci_dev *rcec,
> >>>>> +				  int (*cb)(struct pci_dev *, void *),
> >>>>> +				  void *userdata) { }
> >>>>> +
> >>>>>  #endif
> >>>>> =20
> >>>>> +void pcie_clear_device_status(struct pci_dev *dev);
> >>>>> +
> >>>>>  #define PCIE_LINK_STATE_L0S		(BIT(0) | BIT(1)) /* Upstr/dwnstr L0s=
 */
> >>>>>  #define PCIE_LINK_STATE_L1		BIT(2)	/* L1 state */
> >>>>>  #define PCIE_LINK_STATE_L1_1		BIT(3)	/* ASPM L1.1 state */ =20
> >>> =20
> >  =20
>=20
>=20


