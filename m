Return-Path: <linux-pci+bounces-41253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF76BC5E2B2
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 17:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A1F3BFC5E
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 16:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759B0325717;
	Fri, 14 Nov 2025 16:09:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A3932939D;
	Fri, 14 Nov 2025 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763136594; cv=none; b=HqDgKhB6Tp+xgoUSpi7OymSmKGddJLJ/1bD+9jecRNSnFWJx7CgUPliHrSSD7SmPJlxHaq18JgkQEC1ho3dhGs7r8NLxVMqSNs6asNu3wyov9EP5+9F/RUkRcx7wVKxQgCClncaYvM0xmZdCSV3sdHy9xBVMqCNxKXNNYCDlDgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763136594; c=relaxed/simple;
	bh=pRtMd1SoyFUJdKxhaNPKzWEj3xGqymtep+wzgQhZAe8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=niPGiuu+NKxFZFCEWH03bjMgQ1LA1hqYdOzL0gZYKimc/Bl6VLk1/8yOZX7Hi3gxKGqz4ovpjlBc5zG4KyUuveb0CbO8h06HepYAjXvyL3nwyrN3i3+Mc5KibZ/MyvUHN8k9BfcMROTtCGRCabesxolgdCcmHyh3YT0SdA5gPhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d7MXN6V08zHnH72;
	Sat, 15 Nov 2025 00:09:24 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 28CB3140133;
	Sat, 15 Nov 2025 00:09:48 +0800 (CST)
Received: from localhost (10.126.173.232) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 14 Nov
 2025 16:09:46 +0000
Date: Fri, 14 Nov 2025 16:09:45 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Bowman, Terry" <terry.bowman@amd.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [RESEND v13 22/25] CXL/PCI: Export and rename merge_result() to
 pci_ers_merge_result()
Message-ID: <20251114160945.0000727d@huawei.com>
In-Reply-To: <31f7da35-e603-4272-9e9f-8edc8b4f2075@amd.com>
References: <20251104190348.GA1865266@bhelgaas>
	<31f7da35-e603-4272-9e9f-8edc8b4f2075@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 14 Nov 2025 09:20:08 -0600
"Bowman, Terry" <terry.bowman@amd.com> wrote:

> On 11/4/2025 1:03 PM, Bjorn Helgaas wrote:
> > On Tue, Nov 04, 2025 at 11:03:02AM -0600, Terry Bowman wrote: =20
> >> CXL uncorrectable errors (UCE) will soon be handled separately from th=
e PCI
> >> AER handling. The merge_result() function can be made common to use in=
 both
> >> handling paths.
> >>
> >> Rename the PCI subsystem's merge_result() to be pci_ers_merge_result().
> >> Export pci_ers_merge_result() to make available for the CXL and other
> >> drivers to use.
> >>
> >> Update pci_ers_merge_result() to support recently introduced PCI_ERS_R=
ESULT_PANIC
> >> result. =20
> > Seems like this merge_result() change maybe should be in the same
> > patch that added PCI_ERS_RESULT_PANIC?  That would also solve the
> > problem that the subject line doesn't mention this important
> > functional change.
> >
> > I haven't seen the user(s) of pci_ers_merge_result() yet, but this
> > seems like it might be a little too low level to be exported to
> > modules and in include/linux/pci.h.  Maybe there's no other way. =20
>=20
> This is used in the UCE handling patch. I will move there.
>=20
> Jonathan suggested updating |merge_result()| to handle both PCIe and CXL =
error=A0
> cases with shared logic. The only other option I see is to remove the exp=
ort here=A0
> and duplicate the function in the CXL drivers?

I don't mind if turns out we do need to duplicate this little bit of code.

Jonathan
> /
> /
>=20
> - Terry
>=20
>=20
> > Wrap commit log to fit in 75 columns.
> >
> > Suggest possible subject prefix of "PCI/ERR" since the only CXL
> > connection is that you want to *use* this from CXL.
> > =20
> >> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> >> --- Changes in v12->v13: - Renamed pci_ers_merge_result() to pcie_ers_=
merge_result(). pci_ers_merge_result() is already used in eeh driver. (Bot)=
 Changes in v11->v12: - Remove static inline pci_ers_merge_result() definit=
ion for !CONFIG_PCIEAER. Is not needed. (Lukas) Changes in v10->v11: - New =
patch - pci_ers_merge_result() - Change export to non-namespace and rename =
to be pci_ers_merge_result() - Move pci_ers_merge_result() definition to pc=
i.h. Needs pci_ers_result --- drivers/pci/pcie/err.c | 14 +++++++++----- in=
clude/linux/pci.h | 7 +++++++ 2 files changed, 16 insertions(+), 5 deletion=
s(-) diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c index beb=
e4bc111d7..9394bbdcf0fb 100644 --- a/drivers/pci/pcie/err.c +++ b/drivers/p=
ci/pcie/err.c @@ -21,9 +21,12 @@ #include "portdrv.h" #include "../pci.h" -=
static pci_ers_result_t merge_result(enum pci_ers_result orig, - enum pci_e=
rs_result new) +pci_ers_result_t pcie_ers_merge_result(enum pci_ers_result =
orig, + enum
> >> pci_ers_result new) { + if (new =3D=3D PCI_ERS_RESULT_PANIC) + return =
PCI_ERS_RESULT_PANIC; + if (new =3D=3D PCI_ERS_RESULT_NO_AER_DRIVER) return=
 PCI_ERS_RESULT_NO_AER_DRIVER; @@ -45,6 +48,7 @@ static pci_ers_result_t me=
rge_result(enum pci_ers_result orig, return orig; } +EXPORT_SYMBOL(pcie_ers=
_merge_result); static int report_error_detected(struct pci_dev *dev, pci_c=
hannel_state_t state, @@ -81,7 +85,7 @@ static int report_error_detected(st=
ruct pci_dev *dev, vote =3D err_handler->error_detected(dev, state); } pci_=
uevent_ers(dev, vote); - *result =3D merge_result(*result, vote); + *result=
 =3D pcie_ers_merge_result(*result, vote); device_unlock(&dev->dev); return=
 0; } @@ -139,7 +143,7 @@ static int report_mmio_enabled(struct pci_dev *de=
v, void *data) err_handler =3D pdrv->err_handler; vote =3D err_handler->mmi=
o_enabled(dev); - *result =3D merge_result(*result, vote); + *result =3D pc=
ie_ers_merge_result(*result, vote); out: device_unlock(&dev->dev); return 0=
; @@ -159,7 +163,7 @@ static int
> >> report_slot_reset(struct pci_dev *dev, void *data) err_handler =3D pdr=
v->err_handler; vote =3D err_handler->slot_reset(dev); - *result =3D merge_=
result(*result, vote); + *result =3D pcie_ers_merge_result(*result, vote); =
out: device_unlock(&dev->dev); return 0; diff --git a/include/linux/pci.h b=
/include/linux/pci.h index 33d16b212e0d..d3e3300f79ec 100644 --- a/include/=
linux/pci.h +++ b/include/linux/pci.h @@ -1887,9 +1887,16 @@ static inline =
void pci_hp_unignore_link_change(struct pci_dev *pdev) { } #ifdef CONFIG_PC=
IEAER bool pci_aer_available(void); void pcie_clear_device_status(struct pc=
i_dev *dev); +pci_ers_result_t pcie_ers_merge_result(enum pci_ers_result or=
ig, + enum pci_ers_result new); #else static inline bool pci_aer_available(=
void) { return false; } static inline void pcie_clear_device_status(struct =
pci_dev *dev) { } +static inline pci_ers_result_t pcie_ers_merge_result(enu=
m pci_ers_result orig, + enum pci_ers_result new) +{ + return PCI_ERS_RESUL=
T_NONE; +} #endif bool
> >> pci_ats_disabled(void); -- 2.34.1  =20
>=20


