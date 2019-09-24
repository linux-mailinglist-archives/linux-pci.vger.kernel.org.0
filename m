Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9FE2BC7B0
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2019 14:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504891AbfIXML6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Sep 2019 08:11:58 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:37324 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387414AbfIXML5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Sep 2019 08:11:57 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190924121153epoutp04e79dee5aa5fb886cf0525eb57725289f~HXrH580000960709607epoutp042
        for <linux-pci@vger.kernel.org>; Tue, 24 Sep 2019 12:11:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190924121153epoutp04e79dee5aa5fb886cf0525eb57725289f~HXrH580000960709607epoutp042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569327113;
        bh=EGxGsRM7JqvSPF/mq76OsGiopeDeBorFdYM3QIJYUVk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=nw1xeLtUJG+1IvtmYndNVxJPZyu+UdaGVzVfRchNceOMmn0R9EiWBhSVS/SOm1Nu4
         pTPGj6m6Qi5GvemY23hqHqRddjNOQnJ30O1zNi3zZYxhxJ3/tGUVtU6miRkQwVl6FB
         tKQXd0Zewuesemn+bOB6zC/v65NscueqRv+FwUYA=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20190924121152epcas5p39fc5d5708296a68f3ed2bf06247e124c~HXrHSdq9D1873318733epcas5p3r;
        Tue, 24 Sep 2019 12:11:52 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        81.89.04647.8080A8D5; Tue, 24 Sep 2019 21:11:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20190924121152epcas5p1f4034e404284d1af1916b6f4a7956787~HXrG7j_X91536315363epcas5p1U;
        Tue, 24 Sep 2019 12:11:52 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190924121152epsmtrp162602f908662d886f927ad7092cce548~HXrG64QqT2062620626epsmtrp1Z;
        Tue, 24 Sep 2019 12:11:52 +0000 (GMT)
X-AuditID: b6c32a49-743ff70000001227-3f-5d8a08083f63
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C0.3C.03889.8080A8D5; Tue, 24 Sep 2019 21:11:52 +0900 (KST)
Received: from pankajdubey02 (unknown [107.111.85.21]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190924121151epsmtip200cbbf9afb36bcf3d2b6fe37352a0d00~HXrFe5CtX0551405514epsmtip2E;
        Tue, 24 Sep 2019 12:11:50 +0000 (GMT)
From:   "Pankaj Dubey" <pankaj.dubey@samsung.com>
To:     "'Vidya Sagar'" <vidyas@nvidia.com>,
        "'Gustavo Pimentel'" <Gustavo.Pimentel@synopsys.com>,
        "'Andrew Murray'" <andrew.murray@arm.com>
Cc:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jingoohan1@gmail.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, "'Anvesh Salveru'" <anvesh.s@samsung.com>
In-Reply-To: <72370258-2cbe-32d8-b444-a45b50efa3e0@nvidia.com>
Subject: RE: [PATCH v2] PCI: dwc: Add support to add GEN3 related
 equalization quirks
Date:   Tue, 24 Sep 2019 17:41:50 +0530
Message-ID: <004c01d572d1$406882a0$c13987e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKZmfmIjaX5BaBnMA3N+7vtT2Qq7gGeUxCAAtEE+g8BbnK8pAGPYjqeAXaY7iIC0ICEfAKBzdlCAi6eLpqlL0fcwA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+W27D6XFdUoe7b0o8ZEmVFypbILBjYwKsijSWnlRS6ftqqkQ
        SdacC81HRQ6VaWZmi3CIc7NSljUrlSAriMQMLR9zgearGdX1LvK/zznf8/geOKRY1o75k8mq
        DFatUqbIcU9Jy7PAgM0kqYvb8uLaDjr/txmje6w1GF13OYm29msJuuFHBUG/tVbidE+1Hacd
        rhGCfm+WKjwYY7URMRZ9P8EYTJlMUb4TZ4qbGxHT3D6FmCnTmoPEcc+dCWxKcharDos85Zk0
        /dUlSh88kt2hd+J5yL5HhzxIoLbCdLFGrEOepIxqQ3Crqg8XgkkEPQsOdzCDYLCpEP/Xkl/v
        RILwBIGtwe4OxhHMaMdEfBVOhUHvXDXGCz6UDkHpvTaMF8SUFYFZs5pnDyoSnLUjBM/e1FHo
        ann81wlJSqiNoHsTwqelVAQ03H4gEtgLXlYMSYQxwVBfMy4WHK2D+eH6xfE+1Fn4cv+mSKjx
        hdHnnQTvAagCAhyfH7obouHjBwMhsDeM2Zvd7A+j1zVuToO5O2ViofkKgnJ7FSYIu6Gjr1LC
        GxVTgfDIGiYsWw5FriERnwZKClqNTKjeBLPfut1rV8Fg/l2RwAzcaBrEStB6/ZLT9EtO0y85
        Qf9/mQFJGpEfm86lJrLctvRwFXshlFOmcpmqxNAzaakmtPhWQXtbkb43xoYoEsmXSRWYLk6G
        KbO4nFQbAlIs95GagjRxMmmCMieXVaedVGemsJwNrSQlcl9pGfbuhIxKVGaw51g2nVX/U0Wk
        h38eylAEe5GtOUFR8VTURLTie4Si0NXdc6nUaPGyR5FesYF+2YcNFs2G+E9dfb/a9j/Nmxyd
        eOW0ay+edroOTHbOOkbMTM3Pq/MFC90Vflx5u3PfrpLXdfUDIbXhPrm9AbYG0/a89gi7+rzB
        r/+Q0RI7rMaOiQbWOpLw+JgVmnijXMIlKcODxGpO+QdZq0gEUgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsWy7bCSvC4HR1eswfaX8hbN/7ezWpzdtZDV
        YklThsWuux3sFiu+zGS3uLxrDpvF2XnH2Sze/H7BbnFtO68Dp8eaeWsYPXbOusvusWBTqUdv
        8zs2j74tqxg9tuz/zOjxeZNcAHsUl01Kak5mWWqRvl0CV8br8xMYC46EVlyZuJq5gXGOSxcj
        J4eEgIlE87J3jF2MXBxCArsZJWbf2c0MkZCRmLx6BSuELSyx8t9zdhBbSOAlo8S6BmcQm01A
        X+Lcj3msIM0iAj2MEjOfzAKbxCxwgFFiy41eJoix01kk3v1dxALSwilgJ/Fu0QuwUcICoRL/
        f70BWsfBwSKgKtF1QQckzCtgKbFixmomCFtQ4uTMJ2CtzALaEk9vPoWzly18DXWpgsTPp8vA
        LhURyJJ4tHIqE0SNuMTLo0fYJzAKz0IyahaSUbOQjJqFpGUBI8sqRsnUguLc9NxiwwKjvNRy
        veLE3OLSvHS95PzcTYzgmNPS2sF44kT8IUYBDkYlHl4H1q5YIdbEsuLK3EOMEhzMSiK8m7Ta
        YoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzyucfixQSSE8sSc1OTS1ILYLJMnFwSjUwdh6+4Nuj
        xvrDSb7+y1OHz4H899z+yncKJsUy/n/e9FI3yJpt7dn5N7Zsfl/M9cnkoca58AW7PesOaETf
        POrUlLKx0zrsv8BTxo1HXR09hO7s7nA/N/3FRjHdsgXvl/gYfFO6d62Z97Xv+Xn5jHYze4rm
        86v7Ktw2q7UI9rOb1JQR6eUlPW23EktxRqKhFnNRcSIAjVuuG7UCAAA=
X-CMS-MailID: 20190924121152epcas5p1f4034e404284d1af1916b6f4a7956787
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
        <000001d572ba$6d3040a0$4790c1e0$@samsung.com>
        <72370258-2cbe-32d8-b444-a45b50efa3e0@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Vidya Sagar <vidyas=40nvidia.com>
> Sent: Tuesday, September 24, 2019 4:57 PM
> To: Pankaj Dubey <pankaj.dubey=40samsung.com>; 'Gustavo Pimentel'
> <Gustavo.Pimentel=40synopsys.com>; 'Andrew Murray'
> <andrew.murray=40arm.com>
> Cc: linux-pci=40vger.kernel.org; linux-kernel=40vger.kernel.org;
> jingoohan1=40gmail.com; lorenzo.pieralisi=40arm.com; bhelgaas=40google.co=
m;
> 'Anvesh Salveru' <anvesh.s=40samsung.com>
> Subject: Re: =5BPATCH v2=5D PCI: dwc: Add support to add GEN3 related equ=
alization
> quirks
>=20
> On 9/24/2019 2:58 PM, Pankaj Dubey wrote:
> >
> >
> >> -----Original Message-----
> >> From: Vidya Sagar <vidyas=40nvidia.com>
> >> Sent: Thursday, September 19, 2019 4:54 PM
> >> Subject: Re: =5BPATCH v2=5D PCI: dwc: Add support to add GEN3 related
> >> equalization quirks
> >>
> >> On 9/16/2019 6:22 PM, Gustavo Pimentel wrote:
> >>> On Mon, Sep 16, 2019 at 13:24:1, Andrew Murray
> >> <andrew.murray=40arm.com>
> >>> wrote:
> >>>
> >>>> On Mon, Sep 16, 2019 at 04:36:33PM +0530, Pankaj Dubey wrote:
> >>>>>
> >>>>>
> >>>>>> -----Original Message-----
> >>>>>> From: Andrew Murray <andrew.murray=40arm.com>
> >>>>>> Sent: Monday, September 16, 2019 3:46 PM
> >>>>>> To: Pankaj Dubey <pankaj.dubey=40samsung.com>
> >>>>>> Cc: linux-pci=40vger.kernel.org; linux-kernel=40vger.kernel.org;
> >>>>>> jingoohan1=40gmail.com; gustavo.pimentel=40synopsys.com;
> >>>>>> lorenzo.pieralisi=40arm.com; bhelgaas=40google.com; Anvesh Salveru
> >>>>>> <anvesh.s=40samsung.com>
> >>>>>> Subject: Re: =5BPATCH v2=5D PCI: dwc: Add support to add GEN3 rela=
ted
> >>>>> equalization
> >>>>>> quirks
> >>>>>>
> >>>>>> On Fri, Sep 13, 2019 at 04:09:50PM +0530, Pankaj Dubey wrote:
> >>>>>>> From: Anvesh Salveru <anvesh.s=40samsung.com>
> >>>>>>>
> >>>>>>> In some platforms, PCIe PHY may have issues which will prevent
> >>>>>>> linkup to happen in GEN3 or higher speed. In case equalization
> >>>>>>> fails, link will fallback to GEN1.
> >>>>>>>
> >>>>>>> DesignWare controller gives flexibility to disable GEN3
> >>>>>>> equalization completely or only phase 2 and 3 of equalization.
> >>>>>>>
> >>>>>>> This patch enables the DesignWare driver to disable the PCIe
> >>>>>>> GEN3 equalization by enabling one of the following quirks:
> >>>>>>>    - DWC_EQUALIZATION_DISABLE: To disable GEN3 equalization all
> >>>>>>> phases
> >> I don't think Gen-3 equalization can be skipped altogether.
> >> PCIe Spec Rev 4.0 Ver 1.0 in Section-4.2.3 has the following statement=
.
> >>
> >> =22All the Lanes that are associated with the LTSSM (i.e., those Lanes
> >> that are currently operational or may be operational in the future
> >> due to Link
> >> Upconfigure) must participate in the Equalization procedure=22
> >>
> >> and in Section-4.2.6.4.2.1.1 it says
> >> =22Note: A transition to Recovery.RcvrLock might be used in the case
> >> where the Downstream Port determines that Phase 2 and Phase 3 are not
> >> needed based on the platform and channel characteristics.=22
> >>
> >> Based on the above statements, I think it is Ok to skip only Phases
> >> 2&3 of equalization but not 0&1.
> >> I even checked with our hardware engineers and it seems
> >> DWC_EQUALIZATION_DISABLE is present only for debugging purpose in
> >> hardware simulations and shouldn't be used on real silicon otherwise i=
t seems.
> >>
> >
> > In DesignWare manual we don't see any comment that this feature is for
> debugging purpose only.
> Agree and as I mentioned even I got to know about it offline.
>=20
> > Even if it is meant for debugging purpose, if for some reason in an SoC=
, Gen3/4
> linkup is failing due to equalization, and if disabling equalization is h=
elping then
> IMO it is OK to do it.
> Well, I don't have specific reservations to not have it. We can use this =
as a fall
> back option.
>=20
> > Just to re-confirm we tested one of the NVMe device on Jatson AGX Xavie=
r RC
> with equalization disabled. We do see linkup works well in GEN3. As we ha=
ve
> added this feature as a platform-quirk so only platforms that required th=
is
> feature can enable it.
> >
> Curious to know...You did it because link didn't come up with equalizatio=
n
> enabled? or just as an experiment?
>=20

We did this, just as an experiment.

> > Snippet of lspci (from Jatson AGX Xavier RC) is given below, showing
> > EQ is completely disabled and GEN3 linkup
> > -----
> > 0005:01:00.0 Non-Volatile memory controller: Lite-On Technology
> Corporation Device 21f1 (rev 01) (prog-if 02 =5BNVM Express=5D)
> >          Subsystem: Marvell Technology Group Ltd. Device 1093
> >           <snip>
> >                  LnkCap: Port =230, Speed 8GT/s, Width x4, ASPM L1, Exi=
t Latency L0s
> <512ns, L1 <64us
> >                          ClockPM+ Surprise- LLActRep- BwNot- ASPMOptCom=
p+
> >                  LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
> >                          ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> >                  LnkSta: Speed 8GT/s, Width x4, TrErr- Train- SlotClk+ =
DLActive-
> BWMgmt- ABWMgmt-
> >                  DevCap2: Completion Timeout: Not Supported, TimeoutDis=
+, LTR+,
> OBFF Via message
> >                  DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-=
, LTR+,
> OBFF Disabled
> >                  LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- Sp=
eedDis-
> >                           Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
> >                           Compliance De-emphasis: -6dB
> >                  LnkSta2: Current De-emphasis Level: -6dB, Equalization=
Complete-,
> EqualizationPhase1-
> >                           EqualizationPhase2-, EqualizationPhase3-,
> > LinkEqualizationRequest-
> > -----
> >> - Vidya Sagar
> >>
> >>
> >>>>>>>    - DWC_EQ_PHASE_2_3_DISABLE: To disable GEN3 equalization
> >>>>>>> phase 2 & 3
> >>>>>>>
> >>>>>>> Platform drivers can set these quirks via =22quirk=22 variable of=
 =22dw_pcie=22
> >>>>>>> struct.
> >>>>>>>
> >>>>>>> Signed-off-by: Anvesh Salveru <anvesh.s=40samsung.com>
> >>>>>>> Signed-off-by: Pankaj Dubey <pankaj.dubey=40samsung.com>
> >>>>>>> ---
> >>>>>>> Patchset v1 can be found at:
> >>>>>>>    - 1/2: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> >>
> 3A__lkml.org_lkml_2019_9_10_443&d=3DDwIBAg&c=3DDPL6_X_6JkXFx7AXWqB0tg
> >> &r=3DbkWxpLoW-f-
> >>
> E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=3DMtEKKeJsQvi2UM1eSZUv2vPLLxrYU0aI1
> >> Ry4ICIDaiQ&s=3Ds_nPmMNbQFswYRxQgBkeg4H9J_0FEtzRE-0AruC5WI4&e=3D
> >>>>>>>    - 2/2:
> >>>>>>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.org_l=
k
> >>>>>>> ml
> >>>>>>>
> >> _2019_9_10_444&d=3DDwIBAg&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3DbkWxpLoW-
> f-
> >> E3Ed
> >>>>>>>
> >> iDCCa0_h0PicsViasSlvIpzZvPxs&m=3DMtEKKeJsQvi2UM1eSZUv2vPLLxrYU0aI1Ry
> >>>>>>>
> 4ICIDaiQ&s=3DkkfdwcX6bYcLrnJSgw_GcMMGAjnDTMtN2v6svWuANpk&e=3D
> >>>>>>>
> >>>>>>> Changes w.r.t v1:
> >>>>>>>    - Squashed two patches from v1 into one as suggested by Gustav=
o
> >>>>>>>    - Addressed review comments from Andrew
> >>>>>>>
> >>>>>>>    drivers/pci/controller/dwc/pcie-designware.c =7C 12
> >>>>>>> ++++++++++++ drivers/pci/controller/dwc/pcie-designware.h =7C  9
> +++++++++
> >>>>>>>    2 files changed, 21 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> >>>>>>> b/drivers/pci/controller/dwc/pcie-designware.c
> >>>>>>> index 7d25102..97fb18d 100644
> >>>>>>> --- a/drivers/pci/controller/dwc/pcie-designware.c
> >>>>>>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> >>>>>>> =40=40 -466,4 +466,16 =40=40 void dw_pcie_setup(struct dw_pcie *p=
ci)
> >>>>>>>    		break;
> >>>>>>>    	=7D
> >>>>>>>    	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL,
> val);
> >>>>>>> +
> >>>>>>> +	if (pci->quirk & DWC_EQUALIZATION_DISABLE) =7B
> >>>>>>> +		val =3D dw_pcie_readl_dbi(pci,
> PCIE_PORT_GEN3_RELATED);
> >>>>>>> +		val =7C=3D PORT_LOGIC_GEN3_EQ_DISABLE;
> >>>>>>> +		dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED,
> val);
> >>>>>>> +	=7D
> >>>>>>> +
> >>>>>>> +	if (pci->quirk & DWC_EQ_PHASE_2_3_DISABLE) =7B
> >>>>>>> +		val =3D dw_pcie_readl_dbi(pci,
> PCIE_PORT_GEN3_RELATED);
> >>>>>>> +		val =7C=3D PORT_LOGIC_GEN3_EQ_PHASE_2_3_DISABLE;
> >>>>>>> +		dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED,
> val);
> >>>>>>> +	=7D
> >>>>>>>    =7D
> >>>>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> >>>>>>> b/drivers/pci/controller/dwc/pcie-designware.h
> >>>>>>> index ffed084..e428b62 100644
> >>>>>>> --- a/drivers/pci/controller/dwc/pcie-designware.h
> >>>>>>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> >>>>>>> =40=40 -29,6 +29,10 =40=40
> >>>>>>>    =23define LINK_WAIT_MAX_IATU_RETRIES	5
> >>>>>>>    =23define LINK_WAIT_IATU			9
> >>>>>>>
> >>>>>>> +/* Parameters for GEN3 related quirks */
> >>>>>>> +=23define DWC_EQUALIZATION_DISABLE	BIT(1)
> >>>>>>> +=23define DWC_EQ_PHASE_2_3_DISABLE	BIT(2)
> >>>>>>> +
> >>>>>>>    /* Synopsys-specific PCIe configuration registers */
> >>>>>>>    =23define PCIE_PORT_LINK_CONTROL		0x710
> >>>>>>>    =23define PORT_LINK_MODE_MASK		GENMASK(21, 16)
> >>>>>>> =40=40 -60,6 +64,10 =40=40
> >>>>>>>    =23define PCIE_MSI_INTR0_MASK		0x82C
> >>>>>>>    =23define PCIE_MSI_INTR0_STATUS		0x830
> >>>>>>>
> >>>>>>> +=23define PCIE_PORT_GEN3_RELATED		0x890
> >>>>>>
> >>>>>> I hadn't noticed this in the previous version - what is the
> >>>>>> proper name
> >>>>> for this
> >>>>>> register? Does it end in _RELATED?
> >>>>>
> >>>>> As per SNPS databook the name of the register is =22GEN3_RELATED_OF=
F=22.
> >>>>> It is port logic register so, to keep similarity with other port
> >>>>> logic registers in this file we named it as =22PCIE_PORT_GEN3_RELAT=
ED=22.
> >>>>
> >>>> OK.
> >>>>
> >>>> Reviewed-by: Andrew Murray <andrew.murray=40arm.com>
> >>>>
> >>>> Also is the SNPS databook publicly available? I'd be interested in
> >>>> reading it.
> >>>
> >>> The databook isn't openly available, sorry.
> >>>
> >>> Gustavo
> >>>
> >>>>
> >>>> Thanks,
> >>>>
> >>>> Andrew Murray
> >>>>
> >>>>>
> >>>>>>
> >>>>>> Thanks,
> >>>>>>
> >>>>>> Andrew Murray
> >>>>>>
> >>>>>>> +=23define PORT_LOGIC_GEN3_EQ_PHASE_2_3_DISABLE	BIT(9)
> >>>>>>> +=23define PORT_LOGIC_GEN3_EQ_DISABLE		BIT(16)
> >>>>>>> +
> >>>>>>>    =23define PCIE_ATU_VIEWPORT		0x900
> >>>>>>>    =23define PCIE_ATU_REGION_INBOUND		BIT(31)
> >>>>>>>    =23define PCIE_ATU_REGION_OUTBOUND	0
> >>>>>>> =40=40 -244,6 +252,7 =40=40 struct dw_pcie =7B
> >>>>>>>    	struct dw_pcie_ep	ep;
> >>>>>>>    	const struct dw_pcie_ops *ops;
> >>>>>>>    	unsigned int		version;
> >>>>>>> +	unsigned int		quirk;
> >>>>>>>    =7D;
> >>>>>>>
> >>>>>>>    =23define to_dw_pcie_from_pp(port) container_of((port), struct
> >>>>>>> dw_pcie,
> >>>>>>> pp)
> >>>>>>> --
> >>>>>>> 2.7.4
> >>>>>>>
> >>>>>
> >>>
> >>>
> >
> >


