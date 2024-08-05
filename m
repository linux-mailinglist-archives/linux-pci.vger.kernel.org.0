Return-Path: <linux-pci+bounces-11337-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3F894835D
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 22:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5AF7280DEB
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 20:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F005B14BF86;
	Mon,  5 Aug 2024 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DVRVjdz2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F018713C809;
	Mon,  5 Aug 2024 20:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722889564; cv=none; b=dlpxOUBOafzzjoiIQJOBYZbWESdgewfNBsNuIk6cWlNdRnTHbnesiwoc0MNIUfwRsFsoS9FsE6eakLhUxvq2NBOlUBbMQO2c9LxR5RyQIuzlS/okoVCvo79W+H17ynI3uz5DJ6amIpyCGdF92nhB9U+HpiLprpuRn3320urSMio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722889564; c=relaxed/simple;
	bh=95mmqfmw5dkWn12SiNd5oQysglVgfsYylg5Sm/T2Tbo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eUdvIx/N2D54KrelOaEBJJahP+UEqY89FrRy6O1WBsEWYDebfBoesvz4GUsVUwtQeufLjGcI3lMw/zsfW4rumJikmwlkh1H3KFaOr5gYxDFg0/ss4uMIGqqpP6CGWuSK6L+eS3wRRvuFcu/Fae88IBfjpjTV6BYe4VlEGuS3YaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DVRVjdz2; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722889563; x=1754425563;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=95mmqfmw5dkWn12SiNd5oQysglVgfsYylg5Sm/T2Tbo=;
  b=DVRVjdz2MSn7U6S0E5to+dzDcEle/W5Dpbb5vD8YU2+5HKNa5CueG2Gd
   pa6NRezGVEAC0iU9NV+F4ij0CIkt0wx7ptdyT0TkZKQ+XcPNAk8peIQRf
   GkHkAHXCu5kP46QlL7cAyOVv4iZi2to9pC2guryuGvpQPFCbz+Is+aM8Q
   DUKNfMuy82iptsJCq425NvPtt/lSQvq5gersVXjmlySiY48i0Op0PJ87d
   VGY5KCV4GKCXTYgyEHLXQBOHYHnGyW0I24gczWhJZ2gI7Mo7zbJ3DzaKi
   8HNyN1iJBzjFBzDpa1q7rL23txmBg+ryZjPoCa5hqr5K801F48HnYPvcX
   Q==;
X-CSE-ConnectionGUID: VpXzfftzQUaKwHpcULvxyg==
X-CSE-MsgGUID: BUuV/8TARVOwCrlcMTtAgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="38385006"
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="38385006"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 13:26:02 -0700
X-CSE-ConnectionGUID: MOir0h3LQ+u3z3eFcNj43w==
X-CSE-MsgGUID: CUiPWpxRQnyRD2TlJoT4+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="56211850"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 13:26:01 -0700
Received: from [10.54.75.156] (debox1-desk1.jf.intel.com [10.54.75.156])
	by linux.intel.com (Postfix) with ESMTP id 167D320CFED1;
	Mon,  5 Aug 2024 13:26:01 -0700 (PDT)
Message-ID: <e37536a435630583398307682e1a9aadbabfb497.camel@linux.intel.com>
Subject: Re: [PATCH v8 4/4] PCI/ASPM: Fix L1.2 parameters when enable link
 state
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Jian-Hong Pan <jhp@endlessos.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Nirmal Patel <nirmal.patel@linux.intel.com>, Jonathan Derrick
 <jonathan.derrick@linux.dev>, Paul M Stillwell Jr
 <paul.m.stillwell.jr@intel.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux@endlessos.org
Date: Mon, 05 Aug 2024 13:26:01 -0700
In-Reply-To: <CAPpJ_edybLMtrN_gxP2h9Z-BuYH+RG-qRqMqgZM1oSVoW1sP5A@mail.gmail.com>
References: <20240719075200.10717-2-jhp@endlessos.org>
	 <20240719080255.10998-2-jhp@endlessos.org>
	 <CAPpJ_edybLMtrN_gxP2h9Z-BuYH+RG-qRqMqgZM1oSVoW1sP5A@mail.gmail.com>
Autocrypt: addr=david.e.box@linux.intel.com; prefer-encrypt=mutual;
 keydata=mQENBF2w2YABCACw5TpqmFTR6SgsrNqZE8ro1q2lUgVZda26qIi8GeHmVBmu572RfPydisEpCK246rYM5YY9XAps810ZxgFlLyBqpE/rxB4Dqvh04QePD6fQNui/QCSpyZ6j9F8zl0zutOjfNTIQBkcar28hazL9I8CGnnMko21QDl4pkrq1dgLSgl2r2N1a6LJ2l8lLnQ1NJgPAev4BWo4WAwH2rZ94aukzAlkFizjZXmB/6em+lhinTR9hUeXpTwcaAvmCHmrUMxeOyhx+csO1uAPUjxL7olj2J83dv297RrpjMkDyuUOv8EJlPjvVogJF1QOd5MlkWdj+6vnVDRfO8zUwm2pqg25DABEBAAG0KkRhdmlkIEUuIEJveCA8ZGF2aWQuZS5ib3hAbGludXguaW50ZWwuY29tPokBTgQTAQgAOBYhBBFoZ8DYRC+DyeuV6X7Mry1gl3p/BQJdsNmAAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH7Mry1gl3p/NusIAK9z1xnXphedgZMGNzifGUs2UUw/xNl91Q9qRaYGyNYATI6E7zBYmynsUL/4yNFnXK8P/I7WMffiLoMqmUvNp9pG6oYYj8ouvbCexS21jgw54I3m61M+wTokieRIO/GettVlCGhz7YHlHtGGqhzzWB3CGPSJMwsouDPvyFFE+28p5d2v9l6rXSb7T297Kh50VX9Ele8QEKngrG+Z/u2lr/bHEhvx24vI8ka22cuTaZvThYMwLTSC4kq9L9WgRv31JBSa1pcbcHLOCoUl0RaQwe6J8w9hN2uxCssHrrfhSA4YjxKNIIp3YH4IpvzuDR3AadYz1klFTnEOxIM7fvQ2iGu5AQ0EXbDZgAEIAPGbL3wvbYUDGMoBSN89GtiC6ybWo28JSiYIN5N9LhDTwfWROenkRvmTESaE5fAM24sh8S0h+F+eQ7j/E/RF3pM31gSovTKw0Pxk7GorK
	FSa25CWemxSV97zV8fVegGkgfZkBMLUId+AYCD1d2R+tndtgjrHtVq/AeN0N09xv/d3a+Xzc4ib/SQh9mM50ksqiDY70EDe8hgPddYH80jHJtXFVA7Ar1ew24TIBF2rxYZQJGLe+Mt2zAzxOYeQTCW7WumD/ZoyMm7bg46/2rtricKnpaACM7M0r7g+1gUBowFjF4gFqY0tbLVQEB/H5e9We/C2zLG9r5/Lt22dj7I8A6kAEQEAAYkBNgQYAQgAIBYhBBFoZ8DYRC+DyeuV6X7Mry1gl3p/BQJdsNmAAhsMAAoJEH7Mry1gl3p/Z/AH/Re8YwzY5I9ByPM56B3Vkrh8qihZjsF7/WB14Ygl0HFzKSkSMTJ+fvZv19bk3lPIQi5lUBuU5rNruDNowCsnvXr+sFxFyTbXw0AQXIsnX+EkMg/JO+/V/UszZiqZPkvHsQipCFVLod/3G/yig9RUO7A/1efRi0E1iJAa6qHrPqE/kJANbz/x+9wcx1VfFwraFXbdT/P2JeOcW/USW89wzMRmOo+AiBSnTI4xvb1s/TxSfoLZvtoj2MR+2PW1zBALWYUKHOzhfFKs3cMufwIIoQUPVqGVeH+u6Asun6ZpNRxdDONop+uEXHe6q6LzI/NnczqoZQLhM8d1XqokYax/IZ4=
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jian-Hong,

On Fri, 2024-08-02 at 16:24 +0800, Jian-Hong Pan wrote:
> Jian-Hong Pan <jhp@endlessos.org> =E6=96=BC 2024=E5=B9=B47=E6=9C=8819=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:04=E5=AF=AB=E9=81=93=EF=BC=9A
> >=20
> > Currently, when enable link's L1.2 features with __pci_enable_link_stat=
e(),
> > it configs the link directly without ensuring related L1.2 parameters, =
such
> > as T_POWER_ON, Common_Mode_Restore_Time, and LTR_L1.2_THRESHOLD have be=
en
> > programmed.
> >=20
> > This leads the link's L1.2 between PCIe Root Port and child device gets
> > wrong configs when a caller tries to enabled it.
> >=20
> > Here is a failed example on ASUS B1400CEAE with enabled VMD:
> >=20
> > 10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Core Processor PCI=
e
> > Controller (rev 01) (prog-if 00 [Normal decode])
> > =C2=A0=C2=A0=C2=A0 ...
> > =C2=A0=C2=A0=C2=A0 Capabilities: [200 v1] L1 PM Substates
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCap: PCI-PM_L1.2+ PCI-P=
M_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> > L1_PM_Substates+
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PortCommonModeRestoreTime=3D45us PortTPow=
erOnTime=3D50us
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCtl1: PCI-PM_L1.2- PCI-=
PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T_CommonMode=3D45us LTR1.2_Threshol=
d=3D101376ns
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCtl2: T_PwrOn=3D50us
> >=20
> > 10000:e1:00.0 Non-Volatile memory controller: Sandisk Corp WD Blue SN55=
0
> > NVMe SSD (rev 01) (prog-if 02 [NVM Express])
> > =C2=A0=C2=A0=C2=A0 ...
> > =C2=A0=C2=A0=C2=A0 Capabilities: [900 v1] L1 PM Substates
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCap: PCI-PM_L1.2+ PCI-P=
M_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > L1_PM_Substates+
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PortCommonModeRestoreTime=3D32us PortTPow=
erOnTime=3D10us
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCtl1: PCI-PM_L1.2- PCI-=
PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T_CommonMode=3D0us LTR1.2_Threshold=
=3D0ns
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCtl2: T_PwrOn=3D10us
> >=20
> > According to "PCIe r6.0, sec 5.5.4", before enabling ASPM L1.2 on the P=
CIe
> > Root Port and the child NVMe, they should be programmed with the same
> > LTR1.2_Threshold value. However, they have different values in this cas=
e.
> >=20
> > Invoke aspm_calc_l12_info() to program the L1.2 parameters properly bef=
ore
> > enable L1.2 bits of L1 PM Substates Control Register in
> > __pci_enable_link_state().
> >=20
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218394
> > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > ---
> > v2:
> > - Prepare the PCIe LTR parameters before enable L1 Substates
> >=20
> > v3:
> > - Only enable supported features for the L1 Substates part
> >=20
> > v4:
> > - Focus on fixing L1.2 parameters, instead of re-initializing whole L1S=
S
> >=20
> > v5:
> > - Fix typo and commit message
> > - Split introducing aspm_get_l1ss_cap() to "PCI/ASPM: Introduce
> > =C2=A0 aspm_get_l1ss_cap()"
> >=20
> > v6:
> > - Skipped
> >=20
> > v7:
> > - Pick back and rebase on the new version kernel
> > - Drop the link state flag check. And, always config link state's timin=
g
> > =C2=A0 parameters
> >=20
> > v8:
> > - Because pcie_aspm_get_link() might return the link as NULL, move
> > =C2=A0 getting the link's parent and child devices after check the link=
 is
> > =C2=A0 not NULL. This avoids NULL memory access.
> >=20
> > =C2=A0drivers/pci/pcie/aspm.c | 15 +++++++++++++++
> > =C2=A01 file changed, 15 insertions(+)
> >=20
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 5db1044c9895..55ff1d26fcea 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -1411,9 +1411,15 @@ EXPORT_SYMBOL(pci_disable_link_state);
> > =C2=A0static int __pci_enable_link_state(struct pci_dev *pdev, int stat=
e, bool
> > locked)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pcie_link_state *link=
 =3D pcie_aspm_get_link(pdev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 parent_l1ss_cap, child_l1ss_c=
ap;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_dev *parent, *child;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!link)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parent =3D link->pdev;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 child =3D link->downstream;
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * A driver requested t=
hat ASPM be enabled on this device, but
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * if we don't have per=
mission to manage ASPM (e.g., on ACPI
> > @@ -1428,6 +1434,15 @@ static int __pci_enable_link_state(struct pci_de=
v
> > *pdev, int state, bool locked)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!locked)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 down_read(&pci_bus_sem);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&aspm_lock);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Ensure L1.2 parameters: C=
ommon_Mode_Restore_Times, T_POWER_ON and
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * LTR_L1.2_THRESHOLD are pr=
ogrammed properly before enable bits for
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * L1.2, per PCIe r6.0, sec =
5.5.4.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parent_l1ss_cap =3D aspm_get_l1ss=
_cap(parent);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 child_l1ss_cap =3D aspm_get_l1ss_=
cap(child);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aspm_calc_l12_info(link, parent_l=
1ss_cap, child_l1ss_cap);

I still don't think this is the place to recalculate the L1.2 parameters
especially when know the calculation was done but was cleared by
pci_bus_reset(). Can't we just do a pci_save/restore_state() before/after
pci_bus_reset() in vmd.c?

David

> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 link->aspm_default =3D pci_c=
alc_aspm_enable_mask(state);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcie_config_aspm_link(link, =
policy_to_aspm_state(link));
> >=20
> > --
> > 2.45.2
> >=20
>=20
> Hi Nirmal and Paul,
>=20
> It will be great to have your review here.
>=20
> I had tried to "set the threshold value in vmd_pm_enable_quirk()"
> directly as Paul said [1].=C2=A0 However, it still needs to get the PCIe
> link from the PCIe device to set the threshold value.
> And, pci_enable_link_state_locked() gets the link. Then, it will be
> great to calculate and programm L1 sub-states' parameters properly
> before configuring the link's ASPM there.
>=20
> [1]:
> https://lore.kernel.org/linux-kernel/20240624081108.10143-2-jhp@endlessos=
.org/T/#mc467498213fe1a6116985c04d714dae378976124
>=20
> Jian-Hong Pan


