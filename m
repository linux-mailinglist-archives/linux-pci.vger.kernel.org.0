Return-Path: <linux-pci+bounces-10550-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 765809377C1
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 14:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7649B21066
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 12:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BE513AD04;
	Fri, 19 Jul 2024 12:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ch1l+0iM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BD5135A65
	for <linux-pci@vger.kernel.org>; Fri, 19 Jul 2024 12:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721392177; cv=none; b=cWybl4zmAP5TgZlnPakQsLSEfgs5qLPg8f+M1zvilr+4ELJHGygV6JIpDqC/PCpWA6nywb01zhB9zJFE29O1n2dzb5tYeKES1XBizdvWvJUJpkVSGTK5cjGrZ9gG70bmcWENfHz9j32ecDyj1+uiokEe3606euTcREwHlyia5o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721392177; c=relaxed/simple;
	bh=pbf7W16ISUH4WBjljL9mJmKqagVW2OI3Z+T+BxxM6HM=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=Ta9hogF9v4F7thGSAHU9VziJXLZYx/A13ugdm7D6Y7cwEOCbDbzbcK48HLiR1jwuU4AeQOKAJOsGbMkRWp3tF3e30rjLLC2mTK30joBx461LnCsxuK9s86nHEeiL3M5ZPyBWsvXvR5Pp5mrlvWMbG4/kilSNa62X0Pfyx7rqLfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Ch1l+0iM; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240719122926epoutp02bdbe5459160e72342d5948afc544ad7b~jnQ3-Q8xt1431114311epoutp02k
	for <linux-pci@vger.kernel.org>; Fri, 19 Jul 2024 12:29:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240719122926epoutp02bdbe5459160e72342d5948afc544ad7b~jnQ3-Q8xt1431114311epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721392166;
	bh=K4D+JRBOZVrOy3NCg2PVJkr8GGWGTuqHachYf3HW+fk=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=Ch1l+0iMzhJEPD0ZWb+1zdt7QzckFsXBngtTw+9zab3k0bcASeBLx1SdCKlmhPUQ+
	 48aqaJtHCX9JI/vBCReW7UJxXR8T4EYpc3xTSa4S/5T2M1ZZ3mfLKK48+iGnEmVhil
	 BL+J0G6oaEUKldO5CdN3d0uQnXzcsVdWUaIxWwUI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240719122925epcas5p34f60a037daa10fa1fbdb628f1486740e~jnQ3OJQVR0356803568epcas5p30;
	Fri, 19 Jul 2024 12:29:25 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4WQTWR2sc1z4x9Pv; Fri, 19 Jul
	2024 12:29:23 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	38.91.11095.32C5A966; Fri, 19 Jul 2024 21:29:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240719121215epcas5p15b79bb2cd572930cfd622be52442cbee~jnB4oQBIL1591815918epcas5p1Q;
	Fri, 19 Jul 2024 12:12:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240719121215epsmtrp2a1cd3e0d75e459a8daa42d6ebbf9a3f3~jnB4nYO3r2751027510epsmtrp2Y;
	Fri, 19 Jul 2024 12:12:15 +0000 (GMT)
X-AuditID: b6c32a49-423b770000012b57-89-669a5c230c82
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A2.B3.29940.F185A966; Fri, 19 Jul 2024 21:12:15 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240719121213epsmtip232453a68712b2d46a689948305bb6671~jnB2YYTTd1166811668epsmtip2h;
	Fri, 19 Jul 2024 12:12:13 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Jonathan Cameron'" <Jonathan.Cameron@Huawei.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<manivannan.sadhasivam@linaro.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<fancer.lancer@gmail.com>, <yoshihiro.shimoda.uh@renesas.com>,
	<conor.dooley@microchip.com>, <pankaj.dubey@samsung.com>,
	<gost.dev@samsung.com>
In-Reply-To: <20240701120939.00002d76@Huawei.com>
Subject: RE: [PATCH 2/3] PCI: debugfs: Add support for RASDES framework in
 DWC
Date: Fri, 19 Jul 2024 17:42:11 +0530
Message-ID: <000001dad9d4$e4c8ccf0$ae5a66d0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHKwgKyLB2C4lxb4O3ljLqdkJb8HwLRC2EZAqo5aqACiK3TSLHeAaVw
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKJsWRmVeSWpSXmKPExsWy7bCmhq5yzKw0g85f/BZLmjIspmzawW6x
	oWMOq8XNAzuZLFZ8mclusWrhNTaLhp7frBaXd81hszg77zibRcufFhaLuy2drBaLtn5ht/i/
	B6jt697PbA58Hjtn3WX3WLCp1KPlyFtWj02rOtk87lzbw+bx5Mp0Jo87P5Yyenw7M5HFo2/L
	KkaPz5vkAriism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ0
	3TJzgB5QUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZ
	GhgYmQIVJmRnTD7+i61giknFtA19zA2MuzS7GDk5JARMJJ4cn8/axcjFISSwm1Hi240eRgjn
	E6PEh4MboTLfGCVW3jjJBNNy+8JPVhBbSGAvo0TnhEyIoheMEg+brzOCJNgEdCSeXPnDDGKL
	CJhJ/F32HGwss8BLJokNEy+DdXMKGEpc7dzB0sXIwSEsECDRf7kOJMwioCpxZvclsDm8ApYS
	Hx98YYawBSVOznzCAmIzC8hLbH87hxniIAWJn0+XsULscpP4/PgbO0SNuMTRnz3MIHslBD5w
	SNz4MpMRosFF4tytg2wQtrDEq+Nb2CFsKYnP7/ZCxdMlVm6eAbUgR+Lb5iVQ39tLHLgyB+xm
	ZgFNifW79CHCshJTT61jgtjLJ9H7+wlUOa/EjnkwtrLEl797WCBsSYl5xy6zTmBUmoXktVlI
	XpuF5IVZCNsWMLKsYpRMLSjOTU8tNi0wzEsth0d4cn7uJkZw+tby3MF498EHvUOMTByMhxgl
	OJiVRHj9vs1ME+JNSaysSi3Kjy8qzUktPsRoCgzvicxSosn5wAySVxJvaGJpYGJmZmZiaWxm
	qCTO+7p1boqQQHpiSWp2ampBahFMHxMHp1QDU35KruyH962yuVbzav+kL9y0dwrngfdRz6K7
	Qy16jt1vPX/y00S2wNzmG+IX2XJYLFa06cbyeN12jV+hPP/Dlq/3thgXHNddEzoxQlGE/02+
	xeazy16UxycsmxpSvIf1cYuOrKPEi3X7zwrtUjhs9NuRU5bn7TJvx/1PUxb6PY1010v95lz+
	4+Cz2b2af1MCw+/8+Wq73TXx+A6P95qTSgQL12lPWL1B4r5lmr8bHxtTL9/pn7wb5qj9kj7+
	zLlNwaSB58/NY5uusOhe+ec0WWvzNpe0c9qTHSsv8N9K1KgVaThhmZRwe+dLlj3v1k/Y0F63
	tOHesb27l+urfvTS/rJF9d9/wzPhLpun3ty5aJMSS3FGoqEWc1FxIgD8wzd7aAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsWy7bCSvK58xKw0gyW3tC2WNGVYTNm0g91i
	Q8ccVoubB3YyWaz4MpPdYtXCa2wWDT2/WS0u75rDZnF23nE2i5Y/LSwWd1s6WS0Wbf3CbvF/
	D1Db172f2Rz4PHbOusvusWBTqUfLkbesHptWdbJ53Lm2h83jyZXpTB53fixl9Ph2ZiKLR9+W
	VYwenzfJBXBFcdmkpOZklqUW6dslcGVMPv6LrWCKScW0DX3MDYy7NLsYOTkkBEwkbl/4ydrF
	yMUhJLCbUaJ5118miISkxOeL66BsYYmV/56zQxQ9Y5Q4PnkOI0iCTUBH4smVP8wgtoiAmcTf
	Zc8ZQYqYBb4zSRw6fg2q4xGjxKlT79hBqjgFDCWudu5g6WLk4BAW8JM4NMcNJMwioCpxZvcl
	sKG8ApYSHx98YYawBSVOznwCVs4soCfRthGshFlAXmL72znMEMcpSPx8uowV4gY3ic+Pv7FD
	1IhLHP3ZwzyBUXgWkkmzECbNQjJpFpKOBYwsqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLz
	czcxgiNYS3MH4/ZVH/QOMTJxMB5ilOBgVhLh9fs2M02INyWxsiq1KD++qDQntfgQozQHi5I4
	r/iL3hQhgfTEktTs1NSC1CKYLBMHp1QDk0XvSp/NLpkN2SeYFlx9eLoobsPzFffe33ZiXx5w
	4V6mx/0Z0cKs/R3KNj91J/WYMG2cJMj77cZb5lLGd1Pe3GaS7wg6u/v2RLGJxkpzeJ1iXn9Z
	dtVKs87Vrr5o+snDmX8tmrLeOG82EKlgvb5oUeFmHZ/rAsLFO+Yy+hvPc94SciPUTMjg45P3
	6ZOMLkru9Jrw4tvkr6Ecx4KuRV45eNa2r1t9pmrmDZHAFX9fCbvofs745MHcb3byfWX+l7Pv
	F04UW1X/4rGtw1VmBxa7HfuFM4y72jbkvJ/SEsf2OHhRw/YV3y+a357jOP1dzOOPN5O6Gvbm
	q80QYXCRX/qzX8fSSOjd1QeHvCo3pVi9tVRiKc5INNRiLipOBAD6FTZxTwMAAA==
X-CMS-MailID: 20240719121215epcas5p15b79bb2cd572930cfd622be52442cbee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240625094443epcas5p3093ac786a7d0f09de5a3bba17bbd4458
References: <20240625093813.112555-1-shradha.t@samsung.com>
	<CGME20240625094443epcas5p3093ac786a7d0f09de5a3bba17bbd4458@epcas5p3.samsung.com>
	<20240625093813.112555-3-shradha.t@samsung.com>
	<20240701120939.00002d76@Huawei.com>

> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: 01 July 2024 16:40
> To: Shradha Todi <shradha.t@samsung.com>
> Cc: linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org;
> manivannan.sadhasivam@linaro.org; lpieralisi@kernel.org; kw@linux.com;
> robh@kernel.org; bhelgaas@google.com; jingoohan1@gmail.com;
> fancer.lancer@gmail.com; yoshihiro.shimoda.uh@renesas.com;
> conor.dooley@microchip.com; pankaj.dubey@samsung.com;
> gost.dev@samsung.com
> Subject: Re: [PATCH 2/3] PCI: debugfs: Add support for RASDES framework in DWC
> 
> On Tue, 25 Jun 2024 15:08:12 +0530
> Shradha Todi <shradha.t@samsung.com> wrote:
> 
> > Add support to use the RASDES feature of DesignWare PCIe controller
> > using debugfs entries.
> >
> > RASDES is a vendor specific extended PCIe capability which reads the
> > current hardware internal state of PCIe device. Following primary
> > features are provided to userspace via debugfs:
> > - Debug registers
> > - Error injection
> > - Statistical counters
> >
> > Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> 
> A few minor things inline.
> 
> > +
> > +struct rasdes_info {
> > +	/* to store rasdes capability offset */
> > +	u32 ras_cap;
> > +	struct mutex dbg_mutex;
> 
> Add a comment on what data this mutex protects.
> 
> > +	struct dentry *rasdes;
> > +};
> 
> > +struct err_inj {
> Very generic name is likely to bite in future if similar gets defined in a
header. I'd at
> least prefix with dw_
> 
> > +	const char *name;
> > +	/* values can be from group 0 - 6 */
> > +	u32 err_inj_group;
> > +	/* within each group there can be types */
> > +	u32 err_inj_type;
> > +	/* More details about the error */
> > +	u32 err_inj_12_31;
> > +};
> 
> 
> > +
> > +int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci) {
> > +	struct device *dev = pci->dev;
> > +	int ras_cap;
> > +	struct rasdes_info *dump_info;
> > +	char dirname[DWC_DEBUGFS_MAX];
> > +	struct dentry *dir, *rasdes_debug, *rasdes_err_inj;
> > +	struct dentry *rasdes_event_counter, *rasdes_events;
> > +	int i;
> 
> Perhaps combine with int ras_cap above.
> 
> From a quick look, I think this can get called from resume paths as well as
initial
> setup which doesn't look like a safe thing to do.
> imx6_pcie_resume_irq()
> dw_pcie_setup_rc()
> dw_pcie_setup()
> dwc_pcie_rasdes_debugfs_init()
> 
> 

Thanks for review. I'm going to post the next version soon with all your
comments addressed.
Yes, I guess this is a fair point that calling it during resume path + setup is
not a safe thing to do.
I was thinking we leave it up to  platform drivers to call it and drop patch 3
altogether as I realised
that there is also no ep_deinit to call the
"dwc_pcie_rasdes_debugfs_deinit(pci)" from.
Would love to know your opinion on this before I proceed to post the changes.

> > +	struct rasdes_priv *priv_tmp;
> > +
> > +	ras_cap = dw_pcie_find_vsec_capability(pci, DW_PCIE_RAS_DES_CAP);
> > +	if (!ras_cap) {
> > +		dev_err(dev, "No RASDES capability available\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	dump_info = devm_kzalloc(dev, sizeof(*dump_info), GFP_KERNEL);
> > +	if (!dump_info)
> > +		return -ENOMEM;
> > +
> > +	/* Create main directory for each platform driver */
> > +	sprintf(dirname, "pcie_dwc_%s", dev_name(dev));
> 
> dev_name could in theory be huge.  I'd use snprintf() and check the result as
more
> obviously correct.
> 
> > +	dir = debugfs_create_dir(dirname, NULL);
> 
> Check for errors in all these.
> 
> > +
> > +	/* Create subdirectories for Debug, Error injection, Statistics */
> > +	rasdes_debug = debugfs_create_dir("rasdes_debug", dir);
> > +	rasdes_err_inj = debugfs_create_dir("rasdes_err_inj", dir);
> > +	rasdes_event_counter = debugfs_create_dir("rasdes_event_counter",
> > +dir);
> > +
> > +	mutex_init(&dump_info->dbg_mutex);
> > +	dump_info->ras_cap = ras_cap;
> > +	dump_info->rasdes = dir;
> > +	pci->dump_info = dump_info;
> > +
> > +	/* Create debugfs files for Debug subdirectory */
> > +	dwc_debugfs_create(lane_detect);
> > +	dwc_debugfs_create(rx_valid);
> > +
> > +	/* Create debugfs files for Error injection subdirectory */
> > +	for (i = 0; i < ARRAY_SIZE(err_inj_list); i++) {
> > +		priv_tmp = devm_kzalloc(dev, sizeof(*priv_tmp), GFP_KERNEL);
> > +		if (!priv_tmp)
> > +			goto err;
> > +
> > +		priv_tmp->idx = i;
> > +		priv_tmp->pci = pci;
> > +		debugfs_create_file(err_inj_list[i].name, 0200,
> > +				    rasdes_err_inj, priv_tmp, &err_inj_ops);
> > +	}
> > +
> > +	/* Create debugfs files for Statistical counter subdirectory */
> > +	for (i = 0; i < ARRAY_SIZE(event_counters); i++) {
> > +		priv_tmp = devm_kzalloc(dev, sizeof(*priv_tmp), GFP_KERNEL);
> > +		if (!priv_tmp)
> > +			goto err;
> > +
> > +		priv_tmp->idx = i;
> > +		priv_tmp->pci = pci;
> > +		rasdes_events = debugfs_create_dir(event_counters[i].name,
> > +						   rasdes_event_counter);
> > +		if (event_counters[i].group_no == 0) {
> > +			debugfs_create_file("lane_select", 0644, rasdes_events,
> > +					    priv_tmp, &cnt_lane_ops);
> > +		}
> > +		debugfs_create_file("counter_value", 0444, rasdes_events,
> priv_tmp,
> > +				    &cnt_val_ops);
> > +		debugfs_create_file("counter_enable", 0644, rasdes_events,
> priv_tmp,
> > +				    &cnt_en_ops);
> > +	}
> > +
> > +	return 0;
> > +err:
> > +	dwc_pcie_rasdes_debugfs_deinit(pci);
> > +	return -ENOMEM;
> > +}
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.h
> > b/drivers/pci/controller/dwc/pcie-designware-debugfs.h
> > new file mode 100644
> > index 000000000000..e69de29bb2d1
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> > b/drivers/pci/controller/dwc/pcie-designware.h
> > index 77686957a30d..9fa9f33e4ddb 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -223,6 +223,8 @@
> >
> >  #define PCIE_RAS_DES_EVENT_COUNTER_DATA		0xc
> >
> > +#define DW_PCIE_RAS_DES_CAP			0x2
> 
> I'd be tempted to try and name that in a fashion that makes it clear it is a
vsec
> capability ID.  Currently it sounds like a top level capability ID.
> 
> > +
> >  /*
> >   * The default address offset between dbi_base and atu_base. Root
controller
> >   * drivers are not required to initialize atu_base if the offset
> > matches this @@ -410,6 +412,7 @@ struct dw_pcie {
> >  	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
> >  	struct gpio_desc		*pe_rst;
> >  	bool			suspended;
> > +	void			*dump_info;
> >  };
> 



