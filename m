Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29C5CBC4D2
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2019 11:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409445AbfIXJ2g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Sep 2019 05:28:36 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:12988 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409448AbfIXJ2f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Sep 2019 05:28:35 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190924092831epoutp02c9a9c135e21ef9188bfe5d6b3cc93483~HVcepN_YI1730917309epoutp02P
        for <linux-pci@vger.kernel.org>; Tue, 24 Sep 2019 09:28:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190924092831epoutp02c9a9c135e21ef9188bfe5d6b3cc93483~HVcepN_YI1730917309epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569317311;
        bh=h4DJngHyV3dQvcFRfbj1YR3y2UAC+Ea+G48I4R7V9JI=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=A2LXKoLNbiLki1KWTA0X9iKci8+tpRYWIcAulwxI9Ugw779Srdgpflr0SGBkbKqTd
         RKJlh9WomzWeLbyBzsjP3GYvrMZF2jTBoY6XOzo+/sQwbYS8Yja7dJq3xXa1oIZbDh
         lMh3rAhGrhRbvtcPeucmEBDglF4Wv3IEqBjEW7Bg=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20190924092830epcas5p35f97b6be487018a0f992841034f601f6~HVceL3L3p0830108301epcas5p3x;
        Tue, 24 Sep 2019 09:28:30 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E3.D7.04480.EB1E98D5; Tue, 24 Sep 2019 18:28:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20190924092830epcas5p2b52c78f7f2e41dd94895e574af53edf9~HVcdnZqhF0410904109epcas5p28;
        Tue, 24 Sep 2019 09:28:30 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190924092830epsmtrp1e0c68d7729bc36abb35c5539b9176c24~HVcdmbzQB1148411484epsmtrp16;
        Tue, 24 Sep 2019 09:28:30 +0000 (GMT)
X-AuditID: b6c32a4b-ca3ff70000001180-15-5d89e1be17d6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.52.03889.DB1E98D5; Tue, 24 Sep 2019 18:28:30 +0900 (KST)
Received: from pankajdubey02 (unknown [107.111.85.21]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190924092828epsmtip19b5a194043fcc963cae7d00e8df1bd16~HVcb4aiBv1094210942epsmtip1y;
        Tue, 24 Sep 2019 09:28:28 +0000 (GMT)
From:   "Pankaj Dubey" <pankaj.dubey@samsung.com>
To:     "'Vidya Sagar'" <vidyas@nvidia.com>,
        "'Gustavo Pimentel'" <Gustavo.Pimentel@synopsys.com>,
        "'Andrew Murray'" <andrew.murray@arm.com>
Cc:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jingoohan1@gmail.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, "'Anvesh Salveru'" <anvesh.s@samsung.com>
In-Reply-To: <7ad2b603-49ce-e955-58c4-fba1fb5ca6c8@nvidia.com>
Subject: RE: [PATCH v2] PCI: dwc: Add support to add GEN3 related
 equalization quirks
Date:   Tue, 24 Sep 2019 14:58:26 +0530
Message-ID: <000001d572ba$6d3040a0$4790c1e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKZmfmIjaX5BaBnMA3N+7vtT2Qq7gGeUxCAAtEE+g8BbnK8pAGPYjqeAXaY7iIC0ICEfKVUm0FA
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0gUYRTl29nZmV3cmFbJ65pZSwVqapLCRGIRSqMV9CNKLclFB5VWXXbV
        sn4kbWy6Yqap5KSi+MTMahG19clWPkhFzIIsKR+Vr9R8ZVgY4yj579x77rn3HLgkpmjDlWRM
        XAKri1NrVBKZuP6li4t760ha2OHZT/tpw3oDTvdaSnC67HY0bRlOJeiqpXyCfmspkNC9RZ0S
        emZtgqDfN8hPSJmaohrEvOCGCabYnMhkGGYlzL26asTUtS0iZtG85xwRKvONZDUxSazO0y9c
        Fv157RnSmoOuG7utRAqaP2ZCUhIob3i4+JcwIRmpoJoQ5Cz9wYRiAUFBbb9IKFYQ3F3JFW9J
        hgZXNiUtCFqnhyRCMY2grLkf8VMSyhP6VotwnrCjTAiyKptwnsAoC4IGo5MJkaSU8oPsBQ3f
        tqUuQld9M8ZjMXUAuNHCjT1y6iiMfpwQCXgndOePi4U1blBRMo0JjvbC768VG+vtqFBoWeYD
        8TP2MPn61YZToAwEGB7P4YLAH5bXH0kEbAtTnXWEgJUwmWncxPGwWpqNCeI7CB50Fm6Kj0P7
        YIGYD4BRLvDU4ikc2wEZa+Mivg2UHFKNCmH6IPz63rPpczeMGMpFAmYg5/kIfh/t47ZF47ZF
        47ZF4P4fK0biauTAavWxUazeR3skjr3moVfH6hPjojwi4mPNaOOtXE83InPfGSuiSKSykWsb
        U8MUuDpJnxxrRUBiKju52dUYppBHqpNvsLr4K7pEDau3IkdSrLKXZ+PvLiuoKHUCe5Vltaxu
        ixWRUmUKopWpjmWHlBVqj/Qe3Fr8o6u7KjDL9uQFUUDiT9f2L5VjTR0xpdyAc1cOLQtecdJI
        7f2GvctH3dKdg2qfOAXedB8/G97V902We6sguGhoav78bJDXm8zQgQ5KFZE3wOxaTyCjLvnY
        ODR4+ptC59JmTn3gQuI52ZgqxDdvqCIgUCXWR6u9XDGdXv0PF2IAulIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWy7bCSnO6+h52xBt8mMlk0/9/OanF210JW
        iyVNGRa77nawW6z4MpPd4vKuOWwWZ+cdZ7N48/sFu8W17bwOnB5r5q1h9Ng56y67x4JNpR69
        ze/YPPq2rGL02LL/M6PH501yAexRXDYpqTmZZalF+nYJXBlzbq9iKljoWdF+YgZjA+NNqy5G
        Tg4JAROJW1e+sXcxcnEICexmlHhx8jUzREJGYvLqFawQtrDEyn/PoYpeMkr8ebqWDSTBJqAv
        ce7HPFaQhIhAD6PEzCezGEEcZoEDjBJbbvQyQbRsZ5ZY9/oOUD8HB6eAncSkTzkg3cICoRL/
        f70BW8cioCox69FcRhCbV8BS4tHtF0wQtqDEyZlPWEBsZgFtiac3n8LZyxbCnKog8fPpMrBT
        RQSiJPZ+/csOUSMu8fLoEfYJjMKzkIyahWTULCSjZiFpWcDIsopRMrWgODc9t9iwwCgvtVyv
        ODG3uDQvXS85P3cTIzjqtLR2MJ44EX+IUYCDUYmHV2JbR6wQa2JZcWXuIUYJDmYlEd5NWm2x
        QrwpiZVVqUX58UWlOanFhxilOViUxHnl849FCgmkJ5akZqemFqQWwWSZODilGhhtf6+WnVe8
        Usam8nhv1/61DWmfuDU1VU/9mbJH3NTDzt36/5Rep6ILR5PChaRYIouWF2qwhfxePlOrrGP7
        Xb203swAt0UfNPIzqj97LDt4jnH2t0X/Go5IMOjYJ9ye8egbB/f9EN9sN4XyrrVeNdkMzs0J
        fDt3M6ksfOPu4cDw28DDwrcpWYmlOCPRUIu5qDgRAL1KyTS2AgAA
X-CMS-MailID: 20190924092830epcas5p2b52c78f7f2e41dd94895e574af53edf9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20190913104018epcas5p3d93265a6786dc2b7b8a7d3231bfe9c14
References: <CGME20190913104018epcas5p3d93265a6786dc2b7b8a7d3231bfe9c14@epcas5p3.samsung.com>
        <1568371190-14590-1-git-send-email-pankaj.dubey@samsung.com>
        <20190916101543.GM9720@e119886-lin.cambridge.arm.com>
        <00a401d56c7e$cf3abd30$6db03790$@samsung.com>
        <20190916122400.GO9720@e119886-lin.cambridge.arm.com>
        <DM6PR12MB4010AE07CC6F1CC60A715EE4DA8C0@DM6PR12MB4010.namprd12.prod.outlook.com>
        <7ad2b603-49ce-e955-58c4-fba1fb5ca6c8@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Vidya Sagar <vidyas=40nvidia.com>
> Sent: Thursday, September 19, 2019 4:54 PM
> Subject: Re: =5BPATCH v2=5D PCI: dwc: Add support to add GEN3 related equ=
alization
> quirks
>=20
> On 9/16/2019 6:22 PM, Gustavo Pimentel wrote:
> > On Mon, Sep 16, 2019 at 13:24:1, Andrew Murray
> <andrew.murray=40arm.com>
> > wrote:
> >
> >> On Mon, Sep 16, 2019 at 04:36:33PM +0530, Pankaj Dubey wrote:
> >>>
> >>>
> >>>> -----Original Message-----
> >>>> From: Andrew Murray <andrew.murray=40arm.com>
> >>>> Sent: Monday, September 16, 2019 3:46 PM
> >>>> To: Pankaj Dubey <pankaj.dubey=40samsung.com>
> >>>> Cc: linux-pci=40vger.kernel.org; linux-kernel=40vger.kernel.org;
> >>>> jingoohan1=40gmail.com; gustavo.pimentel=40synopsys.com;
> >>>> lorenzo.pieralisi=40arm.com; bhelgaas=40google.com; Anvesh Salveru
> >>>> <anvesh.s=40samsung.com>
> >>>> Subject: Re: =5BPATCH v2=5D PCI: dwc: Add support to add GEN3 relate=
d
> >>> equalization
> >>>> quirks
> >>>>
> >>>> On Fri, Sep 13, 2019 at 04:09:50PM +0530, Pankaj Dubey wrote:
> >>>>> From: Anvesh Salveru <anvesh.s=40samsung.com>
> >>>>>
> >>>>> In some platforms, PCIe PHY may have issues which will prevent
> >>>>> linkup to happen in GEN3 or higher speed. In case equalization
> >>>>> fails, link will fallback to GEN1.
> >>>>>
> >>>>> DesignWare controller gives flexibility to disable GEN3
> >>>>> equalization completely or only phase 2 and 3 of equalization.
> >>>>>
> >>>>> This patch enables the DesignWare driver to disable the PCIe GEN3
> >>>>> equalization by enabling one of the following quirks:
> >>>>>   - DWC_EQUALIZATION_DISABLE: To disable GEN3 equalization all
> >>>>> phases
> I don't think Gen-3 equalization can be skipped altogether.
> PCIe Spec Rev 4.0 Ver 1.0 in Section-4.2.3 has the following statement.
>=20
> =22All the Lanes that are associated with the LTSSM (i.e., those Lanes th=
at are
> currently operational or may be operational in the future due to Link
> Upconfigure) must participate in the Equalization procedure=22
>=20
> and in Section-4.2.6.4.2.1.1 it says
> =22Note: A transition to Recovery.RcvrLock might be used in the case wher=
e the
> Downstream Port determines that Phase 2 and Phase 3 are not needed based =
on
> the platform and channel characteristics.=22
>=20
> Based on the above statements, I think it is Ok to skip only Phases 2&3 o=
f
> equalization but not 0&1.
> I even checked with our hardware engineers and it seems
> DWC_EQUALIZATION_DISABLE is present only for debugging purpose in
> hardware simulations and shouldn't be used on real silicon otherwise it s=
eems.
>=20

In DesignWare manual we don't see any comment that this feature is for debu=
gging purpose only.
Even if it is meant for debugging purpose, if for some reason in an SoC, Ge=
n3/4 linkup is failing due to equalization, and if disabling equalization i=
s helping then IMO it is OK to do it.=20
Just to re-confirm we tested one of the NVMe device on Jatson AGX Xavier RC=
 with equalization disabled. We do see linkup works well in GEN3. As we hav=
e added this feature as a platform-quirk so only platforms that required th=
is feature can enable it.

Snippet of lspci (from Jatson AGX Xavier RC) is given below, showing EQ is =
completely disabled and GEN3 linkup
-----
0005:01:00.0 Non-Volatile memory controller: Lite-On Technology Corporation=
 Device 21f1 (rev 01) (prog-if 02 =5BNVM Express=5D)
        Subsystem: Marvell Technology Group Ltd. Device 1093
         <snip>
                LnkCap: Port =230, Speed 8GT/s, Width x4, ASPM L1, Exit Lat=
ency L0s <512ns, L1 <64us
                        ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 8GT/s, Width x4, TrErr- Train- SlotClk+ DLAct=
ive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LT=
R+, OBFF Via message
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR=
+, OBFF Disabled
                LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDi=
s-
                         Transmit Margin: Normal Operating Range, EnterModi=
fiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationCompl=
ete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqua=
lizationRequest-
-----
> - Vidya Sagar
>=20
>=20
> >>>>>   - DWC_EQ_PHASE_2_3_DISABLE: To disable GEN3 equalization phase 2
> >>>>> & 3
> >>>>>
> >>>>> Platform drivers can set these quirks via =22quirk=22 variable of =
=22dw_pcie=22
> >>>>> struct.
> >>>>>
> >>>>> Signed-off-by: Anvesh Salveru <anvesh.s=40samsung.com>
> >>>>> Signed-off-by: Pankaj Dubey <pankaj.dubey=40samsung.com>
> >>>>> ---
> >>>>> Patchset v1 can be found at:
> >>>>>   - 1/2: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__lkml.org_lkml_2019_9_10_443&d=3DDwIBAg&c=3DDPL6_X_6JkXFx7AXWqB0tg
> &r=3DbkWxpLoW-f-
> E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=3DMtEKKeJsQvi2UM1eSZUv2vPLLxrYU0aI1
> Ry4ICIDaiQ&s=3Ds_nPmMNbQFswYRxQgBkeg4H9J_0FEtzRE-0AruC5WI4&e=3D
> >>>>>   - 2/2:
> >>>>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.org_lkm=
l
> >>>>>
> _2019_9_10_444&d=3DDwIBAg&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3DbkWxpLoW-f-
> E3Ed
> >>>>>
> iDCCa0_h0PicsViasSlvIpzZvPxs&m=3DMtEKKeJsQvi2UM1eSZUv2vPLLxrYU0aI1Ry
> >>>>> 4ICIDaiQ&s=3DkkfdwcX6bYcLrnJSgw_GcMMGAjnDTMtN2v6svWuANpk&e=3D
> >>>>>
> >>>>> Changes w.r.t v1:
> >>>>>   - Squashed two patches from v1 into one as suggested by Gustavo
> >>>>>   - Addressed review comments from Andrew
> >>>>>
> >>>>>   drivers/pci/controller/dwc/pcie-designware.c =7C 12 ++++++++++++
> >>>>> drivers/pci/controller/dwc/pcie-designware.h =7C  9 +++++++++
> >>>>>   2 files changed, 21 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> >>>>> b/drivers/pci/controller/dwc/pcie-designware.c
> >>>>> index 7d25102..97fb18d 100644
> >>>>> --- a/drivers/pci/controller/dwc/pcie-designware.c
> >>>>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> >>>>> =40=40 -466,4 +466,16 =40=40 void dw_pcie_setup(struct dw_pcie *pci=
)
> >>>>>   		break;
> >>>>>   	=7D
> >>>>>   	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> >>>>> +
> >>>>> +	if (pci->quirk & DWC_EQUALIZATION_DISABLE) =7B
> >>>>> +		val =3D dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
> >>>>> +		val =7C=3D PORT_LOGIC_GEN3_EQ_DISABLE;
> >>>>> +		dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
> >>>>> +	=7D
> >>>>> +
> >>>>> +	if (pci->quirk & DWC_EQ_PHASE_2_3_DISABLE) =7B
> >>>>> +		val =3D dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
> >>>>> +		val =7C=3D PORT_LOGIC_GEN3_EQ_PHASE_2_3_DISABLE;
> >>>>> +		dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
> >>>>> +	=7D
> >>>>>   =7D
> >>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> >>>>> b/drivers/pci/controller/dwc/pcie-designware.h
> >>>>> index ffed084..e428b62 100644
> >>>>> --- a/drivers/pci/controller/dwc/pcie-designware.h
> >>>>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> >>>>> =40=40 -29,6 +29,10 =40=40
> >>>>>   =23define LINK_WAIT_MAX_IATU_RETRIES	5
> >>>>>   =23define LINK_WAIT_IATU			9
> >>>>>
> >>>>> +/* Parameters for GEN3 related quirks */
> >>>>> +=23define DWC_EQUALIZATION_DISABLE	BIT(1)
> >>>>> +=23define DWC_EQ_PHASE_2_3_DISABLE	BIT(2)
> >>>>> +
> >>>>>   /* Synopsys-specific PCIe configuration registers */
> >>>>>   =23define PCIE_PORT_LINK_CONTROL		0x710
> >>>>>   =23define PORT_LINK_MODE_MASK		GENMASK(21, 16)
> >>>>> =40=40 -60,6 +64,10 =40=40
> >>>>>   =23define PCIE_MSI_INTR0_MASK		0x82C
> >>>>>   =23define PCIE_MSI_INTR0_STATUS		0x830
> >>>>>
> >>>>> +=23define PCIE_PORT_GEN3_RELATED		0x890
> >>>>
> >>>> I hadn't noticed this in the previous version - what is the proper
> >>>> name
> >>> for this
> >>>> register? Does it end in _RELATED?
> >>>
> >>> As per SNPS databook the name of the register is =22GEN3_RELATED_OFF=
=22.
> >>> It is port logic register so, to keep similarity with other port
> >>> logic registers in this file we named it as =22PCIE_PORT_GEN3_RELATED=
=22.
> >>
> >> OK.
> >>
> >> Reviewed-by: Andrew Murray <andrew.murray=40arm.com>
> >>
> >> Also is the SNPS databook publicly available? I'd be interested in
> >> reading it.
> >
> > The databook isn't openly available, sorry.
> >
> > Gustavo
> >
> >>
> >> Thanks,
> >>
> >> Andrew Murray
> >>
> >>>
> >>>>
> >>>> Thanks,
> >>>>
> >>>> Andrew Murray
> >>>>
> >>>>> +=23define PORT_LOGIC_GEN3_EQ_PHASE_2_3_DISABLE	BIT(9)
> >>>>> +=23define PORT_LOGIC_GEN3_EQ_DISABLE		BIT(16)
> >>>>> +
> >>>>>   =23define PCIE_ATU_VIEWPORT		0x900
> >>>>>   =23define PCIE_ATU_REGION_INBOUND		BIT(31)
> >>>>>   =23define PCIE_ATU_REGION_OUTBOUND	0
> >>>>> =40=40 -244,6 +252,7 =40=40 struct dw_pcie =7B
> >>>>>   	struct dw_pcie_ep	ep;
> >>>>>   	const struct dw_pcie_ops *ops;
> >>>>>   	unsigned int		version;
> >>>>> +	unsigned int		quirk;
> >>>>>   =7D;
> >>>>>
> >>>>>   =23define to_dw_pcie_from_pp(port) container_of((port), struct
> >>>>> dw_pcie,
> >>>>> pp)
> >>>>> --
> >>>>> 2.7.4
> >>>>>
> >>>
> >
> >


