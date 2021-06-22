Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F24C3AFC81
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 07:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhFVFPx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Jun 2021 01:15:53 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:29166 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229612AbhFVFPx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Jun 2021 01:15:53 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15M5CItn032587;
        Mon, 21 Jun 2021 22:13:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=9k669+/qUrnB0rmntSr17Vy9DoRKJxbjcO3ngI9cUp4=;
 b=SKT6Oq0teNe7U488t8ubSWqfzOAjSkaTVkOv2a6IgJGC1EYZgoOcBMFxfHg3QInbbfX0
 PtpAtJGCmrqxgPDLd6KlpNYUpqsR6GD+ZXmOM2rWbJ/i1TIoWsUWLe6AMcmjz+N+2NTm
 AOJRwOiUVmMjM4CH3rp6drYgZktRJdLAhZPtgP+mozmx7FpeV9z6PPR5gs2N10z7C7wS
 enqrcHAp3v/2Kp7HOqvPVFn+/V+WwSqW/+7OMeZJLI6vwfTzibb0f5l9QLYH2+NbwCcY
 sEiBjn3UgE9RmpxxYIFXbF3vmBcD0u8JykW2c/t1mns+gI+EF2VeolC1BSx3f40H7npM oA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by mx0a-0014ca01.pphosted.com with ESMTP id 39apms3ae7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 22:13:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lh1G+qsZjn0JDdnML/vztBh5oCrhlnShTwEaLPDZ42VRDKret9PHwSzQPLAOt+90cqHBqqzfPfF6hcb8piB/RKGZgrekxkibPYLPnjHJrqoZx2jnVSmvaTfz14M+tRK+MeKtRXvgZjUIpXMs+TaKSwnUXDKoN9Co68ES+5vpu64VC1EM1/sigroCYSKLax+5t6Pyjz9Vf/Ttqm8dwlGQtEKQeW7GxvAPDClqYdXa6fKl8gEztuNHjvJzcrTRGVfN8MFQQTvpEoGCUmUpxwx0HbgZQzWqAT8aQRibyY50W9EsXDXG2kKTBZXdpDeti7a9KlTewXt3hRfn6zkAXNJ7VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9k669+/qUrnB0rmntSr17Vy9DoRKJxbjcO3ngI9cUp4=;
 b=bsa+CqwYfBzfQFWUy5XVEP4VYllUBKS8Q/omwCDzopEk7/myj2sp9Fvy4BgGSt60gZ6bxTDV83vAqdbQ5328eUKGohtTkHTD5QTZ6MKhZ3/7I9e16NB6/arPcnfSrWYbNmUAs2UBiDkGaok3r7qMmo4hyZaDC7XrWsIMXHHgrkyhDm/2BYIrXtWoWPD40dB/xQxIlKy+32BtfR6jZTXYR6CRLuI9G4Z/VMe0AN2xBhUFZ+w/5R1aXshmQqSTkRWtNfSjjFV4HTXloaDF1Y7f5Fd5SOOb1EvrU+65Dk63AMnATJzOsR2YvX6t8hhrRWpZL/g6cKXzdor3Uqx6rbcgtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9k669+/qUrnB0rmntSr17Vy9DoRKJxbjcO3ngI9cUp4=;
 b=YP1rFIJmNpPj7iFx0poA+9AitP4ij2jagjMEQv3DJdT7cSPp83XSTwx1Mwd24MUvSZEghwTUeBg+oUmL1mtUwZukkBVfrcNVlr9S9JZ1f2AGpy7PAfCvGWvMYlf7NrquHc+7THk8OGdc7GOk6/tl6t/QB+kavBMVgx5Z6rYBHkc=
Received: from CO2PR07MB2503.namprd07.prod.outlook.com (2603:10b6:100:1::19)
 by MWHPR07MB2798.namprd07.prod.outlook.com (2603:10b6:300:22::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Tue, 22 Jun
 2021 05:13:24 +0000
Received: from CO2PR07MB2503.namprd07.prod.outlook.com
 ([fe80::2547:1fe2:65b5:20ff]) by CO2PR07MB2503.namprd07.prod.outlook.com
 ([fe80::2547:1fe2:65b5:20ff%12]) with mapi id 15.20.4242.023; Tue, 22 Jun
 2021 05:13:24 +0000
From:   Athani Nadeem Ladkhan <nadeem@cadence.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Tom Joseph <tjoseph@cadence.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kw@linux.com" <kw@linux.com>, "kishon@ti.com" <kishon@ti.com>,
        Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Parshuram Raju Thombare <pthombar@cadence.com>
Subject: RE: [PATCH] [v2] PCI: cadence: Set LTSSM Detect Quiet state minimum
 delay as workaround for training defect.
Thread-Topic: [PATCH] [v2] PCI: cadence: Set LTSSM Detect Quiet state minimum
 delay as workaround for training defect.
Thread-Index: AQHXU9oM6tIqQ+jZ4Uq1yc3zn273c6se2xKAgADF2UA=
Date:   Tue, 22 Jun 2021 05:13:23 +0000
Message-ID: <CO2PR07MB2503BEB6B23A27E99A8A6EADD8099@CO2PR07MB2503.namprd07.prod.outlook.com>
References: <20210528155626.21793-1-nadeem@cadence.com>
 <20210621171751.GA32574@lpieralisi>
In-Reply-To: <20210621171751.GA32574@lpieralisi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbmFkZWVtXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctOGRjOTIwZmEtZDMxOC0xMWViLWFlYTAtZDQ4MWQ3OWExZmRlXGFtZS10ZXN0XDhkYzkyMGZiLWQzMTgtMTFlYi1hZWEwLWQ0ODFkNzlhMWZkZWJvZHkudHh0IiBzej0iOTQzNSIgdD0iMTMyNjg4MTIzOTg2ODgxMDk4IiBoPSJaWVQ5akNHS1hEMjZ2bDBkZ0VhVGhqRlMza2M9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07cddce4-1a91-4ec8-4e83-08d9353c75f5
x-ms-traffictypediagnostic: MWHPR07MB2798:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR07MB2798B29CA370A576E7864E52D8099@MWHPR07MB2798.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IiamGhhWIrYu058UZo7UnKdmeS8n/eldZoxLNgcA+zO7xkKr/fV495bgi9pfXd1r4Qxk1w/nTs2ZmbyZ+YC/uG9tAGVOs4r/8lJzSECwShzoNc3j38MRcJ3kh5nhiuJHCI8ZwbQJal2AWMkqr8v/DO41Yiv8FGmcTeoAlE+plHgwKoT3uvWgSCbD+ziRmuSYpB3Untye2suoQgus3BFcK0xaR+BLAMvlAdzLC7mRalmnK8kUDRZqHjXS70Nh931B4zd1bUVjV0yKUc7wGt+vFG8pjG3ZRY+4hvVmEzR/vxbH0ZXa4E0EKM+uaZrfT1+sO4IPZEE/ac9MT1VmrqSjd07j37NHEcklm1bGRySS/VZmhv8Cj+Evjlg5okaVknA+TqBkPh5YU0oOWjTSthUB63KSiX1IKM6jw3TYlMYCN+ggAI/E93WhNsR9OuWqvA9jdJOGii/2tCJ5Bw341/B/ttoKxK4kKuKfnyPTGN8LP3m6yzc8fmCYFQsVtTuiPPOjTW6vGMh/IHjIXwHCvofjYKszBePPN93VKix6JaxFnmH0XOyGxR/e2Kse5wbi0Upw5nFrNzxyKCRuLLu35x5B2RhqOKqSsAntYK1nB+1fe/7YHqwwkEg1fgSBhbxH9vuZLoUyQggvufTJWr+EP088EZOMbmcmnG0maoPmVJn/Ww46gk3Q9vWdt6SuCth/kCBzYCoPz7bUsMnd6gkYjBW2J2tbdDihdCR5iRQeZstk1C1+U+ZHpUF04adhUitvA8stYYJrB9v3p8fi86ynTv3LgaUnrL3erDnpV7BcCE+9XwrmT7/JipU5FDiqvZvjUSCf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO2PR07MB2503.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(39850400004)(396003)(346002)(36092001)(55016002)(6506007)(53546011)(122000001)(54906003)(8936002)(64756008)(66446008)(76116006)(6916009)(66946007)(66556008)(38100700002)(186003)(5660300002)(66476007)(33656002)(7696005)(107886003)(966005)(316002)(52536014)(478600001)(83380400001)(9686003)(8676002)(2906002)(86362001)(71200400001)(4326008)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xz+axHjnOnM0+zkrGaeOOBglIV+7YTLi2/MTwSnJg44IbtA88igzmQGJ/OK4?=
 =?us-ascii?Q?ce8Xv2PTaZ23PpTNgOB36g5tFUelfqNE9zTK5PUbnoZnWOGrXgtOinlHk+L3?=
 =?us-ascii?Q?BgpiPhnlDKN3ciLHV4T1T/Z7xQH9rQj1QTpBhvfw3m6RLb2KzivT+dwhLQMs?=
 =?us-ascii?Q?L8jqBfgCc93FL2/hcgiGX9NTm0L3BRSyUPYwE10YivglUIsyqEExcr0mehmp?=
 =?us-ascii?Q?rdajLfAt4M36WabtIRWvM94aIGz4DKXK8S9tAnKKo0GW8bn7hTEo1f692B07?=
 =?us-ascii?Q?50eA3GN7aslW+m167oLg9ekzQgN4AxToJWED8apjt3D+P+MydZDNthC9rtde?=
 =?us-ascii?Q?G/TIWxLmHc4I0MhY23PRFXARMpZ89amYXHjXa5fDQKrUWIwMcBUjGYZfQI2u?=
 =?us-ascii?Q?hTq7ZnrjDRCXvBgs1kn3aJT//QqXc8nsSiBgGvJjxoZ90NYRZp8CkY73IOzD?=
 =?us-ascii?Q?mL4Lv4hHQCr+oYdLH4cJ1rzwjC8Xtyr4p6pMknNBXBbNvSlyYIGk47njJqPF?=
 =?us-ascii?Q?uuZdQI4aZqPGz8kJ09ygZI215X0CV+RQTSCKo/UzRgFUInGLyxwki0N/sUkw?=
 =?us-ascii?Q?HF53YfXQISndEYKJmq/KS+6SdT8ejb8S+hObnPN+2DAehchqaSUMD/alMQpw?=
 =?us-ascii?Q?GrBwAsprYhtrEQ4KdMW67WmLPkzqU73E0XtqJmjyLVgnLzz3G3cJxJEh+Etp?=
 =?us-ascii?Q?/CHJfBFh4dfuSskLtN0+mO/6tIjORNwFmQIF3D5odfWESeCRpg2enyzrXzsz?=
 =?us-ascii?Q?jpUtmLTYhJPq6UcmuJFYOCY1LP+4CbKxyqTkoFKI7sxcRvacIhqF/QboOcKD?=
 =?us-ascii?Q?iZV0rZjUvdlD8QnzDeo7tOej3jXZgI1VcSl1qTtzPl9k8vr4qN5tyHm9Hzte?=
 =?us-ascii?Q?4rXXvmP3zzkYPtt7NIQr7VOJ6ipfP39Q+ao0Ra5BkS68L/CwR6ul5GSWi2Ph?=
 =?us-ascii?Q?VY9vvnW8Upxe0XwAdoczLQTpFDspSkmY1MNvAxZptogdkKjGJf4SV/UD1hPl?=
 =?us-ascii?Q?EpieUoiFsgd0fOigyEIBHUsY24v3/znAuYTNXtk9Ta3XICJRk1pwPNu0Djju?=
 =?us-ascii?Q?WSJ4uzSaQ3i3PSYs1jtmWoz1TKsjIfnOxu9cTjuhXz3SbNPHw5sT1+LIwhFy?=
 =?us-ascii?Q?8ll6FA//xDezTPcUmf0X6AylXkZMagbzoWwLUPMMQvgk/CwMBjclFITiwH0f?=
 =?us-ascii?Q?aADjMLxsRiuanv0MgHyHXyaEtxX31cfcaPjXLQF+IUsvHkov++v7dHZ/dhwJ?=
 =?us-ascii?Q?HPBTqUl+uKpm7aiUHoDzVs00MEmjhkjZ0GS+bRpLGi7vd5g+Pjgcq/xAsGL3?=
 =?us-ascii?Q?v6GDvVq7mpFNYxYfmUUfKWTx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO2PR07MB2503.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07cddce4-1a91-4ec8-4e83-08d9353c75f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 05:13:24.0187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0HGhzmWiqS1sSndtAnkfaySSNpY3HALXNcELYVhXHy6qLoAasstgZPCdhgng/nDS9spfrDucpvKlh6gof7pWxNbhYjsxFkDE2yTf2NTeGa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB2798
X-Proofpoint-ORIG-GUID: zxD0tKfDmwpi42sdAIp5UnoBgLDsEhgh
X-Proofpoint-GUID: zxD0tKfDmwpi42sdAIp5UnoBgLDsEhgh
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-22_03:2021-06-21,2021-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106220031
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

> -----Original Message-----
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Monday, June 21, 2021 10:48 PM
> To: Athani Nadeem Ladkhan <nadeem@cadence.com>
> Cc: Tom Joseph <tjoseph@cadence.com>; robh@kernel.org;
> bhelgaas@google.com; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; kw@linux.com; kishon@ti.com; Milind Parab
> <mparab@cadence.com>; Swapnil Kashinath Jakhade
> <sjakhade@cadence.com>; Parshuram Raju Thombare
> <pthombar@cadence.com>
> Subject: Re: [PATCH] [v2] PCI: cadence: Set LTSSM Detect Quiet state
> minimum delay as workaround for training defect.
>=20
> EXTERNAL MAIL
>=20
>=20
> Subjects should not end with a period, remove it.
This will be corrected in next patch.
>=20
> On Fri, May 28, 2021 at 05:56:26PM +0200, Nadeem Athani wrote:
> > PCIe fails to link up if SERDES lanes not used by PCIe are assigned to
> > another protocol. For example, link training fails if lanes 2 and 3
> > are assigned to another protocol while lanes 0 and 1 are used for PCIe
> > to form a two lane link. This failure is due to an incorrect tie-off
> > on an internal status signal indicating electrical idle.
> >
> > Status signals going from SERDES to PCIe Controller are tied-off when
> > a lane is not assigned to PCIe. Signal indicating electrical idle is
> > incorrectly tied-off to a state that indicates non-idle. As a result,
> > PCIe sees unused lanes to be out of electrical idle and this causes
> > LTSSM to exit Detect.Quiet state without waiting for 12ms timeout to
> > occur. If a receiver is not detected on the first receiver detection
> > attempt in Detect.Active state, LTSSM goes back to Detect.Quiet and
> > again moves forward to Detect.Active state without waiting for 12ms as
> > required by PCIe base specification. Since wait time in Detect.Quiet
> > is skipped, multiple receiver detect operations are performed
> > back-to-back without allowing time for capacitance on the transmit
> > lines to discharge. This causes subsequent receiver detection to
> > always fail even if a receiver gets connected eventually.
> >
> > Adding a quirk flag "quirk_detect_quiet_flag" to program the minimum
> > time that LTSSM waits on entering Detect.Quiet state.
> > Setting this to 2ms for specific TI j7200 SOC as a workaround to
> > resolve a link training issue in IP.
> > In future revisions this setting will not be required.
> >
> > As per PCIe specification, all Receivers must meet the Z-RX-DC
> > specification for 2.5 GT/s within 1ms of entering Detect.Quiet LTSSM
> > substate. The LTSSM must stay in this substate until the ZRXDC
> > specification for 2.5 GT/s is met.
> >
> > 00 : 0 minimum wait time in Detect.Quiet state.
> > 01 : 100us minimum wait time in Detect.Quiet state.
> > 10 : 1ms minimum wait time in Detect.Quiet state.
> > 11 : 2ms minimum wait time in Detect.Quiet state.
> >
> > Changes in v2:
> > 1. Adding the function cdns_pcie_detect_quiet_min_delay_set in
> > pcie-cadence.c and invoking it from host and endpoint driver file.
> >
> > Signed-off-by: Nadeem Athani <nadeem@cadence.com>
> > ---
> >  drivers/pci/controller/cadence/pcie-cadence-ep.c   |  4 ++++
> >  drivers/pci/controller/cadence/pcie-cadence-host.c |  3 +++
> >  drivers/pci/controller/cadence/pcie-cadence.c      | 17 ++++++++++++++=
+++
> >  drivers/pci/controller/cadence/pcie-cadence.h      | 15 ++++++++++++++=
+
> >  4 files changed, 39 insertions(+)
>=20
> Can you tell me please what's the status of these patches ?
These should be discarded.
>=20
> https://urldefense.com/v3/__https://patchwork.kernel.org/user/todo/linux-
> pci/?series=3D&submitter=3D194539&state=3D&q=3D&archive=3D__;!!EHscmS1ygi=
U1lA!S
> ffFfz2_4D72wnwKo_Hgq310uaxhkR7jk4l5vQMYCgwFPYLHDivDXtqJ1uu_RA$
>=20
> Are they all solving the same problem so I only have to review:
Only need to review the below one.
>=20
> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-
> pci/patch/20210528155626.21793-1-
> nadeem@cadence.com__;!!EHscmS1ygiU1lA!SffFfz2_4D72wnwKo_Hgq310ua
> xhkR7jk4l5vQMYCgwFPYLHDivDXtorT4PhuQ$
>=20
> ?
>=20
> I am asking because the "first" posting was a two-patch series and then i=
t
> became one, I lost track of versions in between.
>=20
> Thanks,
> Lorenzo
>=20
> > diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > index 897cdde02bd8..dd7df1ac7fda 100644
> > --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > @@ -623,6 +623,10 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
> >  	ep->irq_pci_addr =3D CDNS_PCIE_EP_IRQ_PCI_ADDR_NONE;
> >  	/* Reserve region 0 for IRQs */
> >  	set_bit(0, &ep->ob_region_map);
> > +
> > +	if (ep->quirk_detect_quiet_flag)
> > +		cdns_pcie_detect_quiet_min_delay_set(&ep->pcie);
> > +
> >  	spin_lock_init(&ep->lock);
> >
> >  	return 0;
> > diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c
> > b/drivers/pci/controller/cadence/pcie-cadence-host.c
> > index ae1c55503513..fb96d37a135c 100644
> > --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> > +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> > @@ -498,6 +498,9 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
> >  		return PTR_ERR(rc->cfg_base);
> >  	rc->cfg_res =3D res;
> >
> > +	if (rc->quirk_detect_quiet_flag)
> > +		cdns_pcie_detect_quiet_min_delay_set(&rc->pcie);
> > +
> >  	ret =3D cdns_pcie_start_link(pcie);
> >  	if (ret) {
> >  		dev_err(dev, "Failed to start link\n"); diff --git
> > a/drivers/pci/controller/cadence/pcie-cadence.c
> > b/drivers/pci/controller/cadence/pcie-cadence.c
> > index 3c3646502d05..65b6c8bed0d4 100644
> > --- a/drivers/pci/controller/cadence/pcie-cadence.c
> > +++ b/drivers/pci/controller/cadence/pcie-cadence.c
> > @@ -7,6 +7,23 @@
> >
> >  #include "pcie-cadence.h"
> >
> > +void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie) {
> > +	u32 delay =3D 0x3;
> > +	u32 ltssm_control_cap;
> > +
> > +	/*
> > +	 * Set the LTSSM Detect Quiet state min. delay to 2ms.
> > +	 */
> > +
> > +	ltssm_control_cap =3D cdns_pcie_readl(pcie,
> CDNS_PCIE_LTSSM_CONTROL_CAP);
> > +	ltssm_control_cap =3D ((ltssm_control_cap &
> > +			    ~CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK) |
> > +			    CDNS_PCIE_DETECT_QUIET_MIN_DELAY(delay));
> > +
> > +	cdns_pcie_writel(pcie, CDNS_PCIE_LTSSM_CONTROL_CAP,
> > +ltssm_control_cap); }
> > +
> >  void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u=
8
> fn,
> >  				   u32 r, bool is_io,
> >  				   u64 cpu_addr, u64 pci_addr, size_t size) diff
> --git
> > a/drivers/pci/controller/cadence/pcie-cadence.h
> > b/drivers/pci/controller/cadence/pcie-cadence.h
> > index 254d2570f8c9..ccdf9cee9dde 100644
> > --- a/drivers/pci/controller/cadence/pcie-cadence.h
> > +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> > @@ -189,6 +189,14 @@
> >  /* AXI link down register */
> >  #define CDNS_PCIE_AT_LINKDOWN (CDNS_PCIE_AT_BASE + 0x0824)
> >
> > +/* LTSSM Capabilities register */
> > +#define CDNS_PCIE_LTSSM_CONTROL_CAP             (CDNS_PCIE_LM_BASE +
> 0x0054)
> > +#define  CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK  GENMASK(2, 1)
> #define
> > +CDNS_PCIE_DETECT_QUIET_MIN_DELAY_SHIFT 1 #define
> > +CDNS_PCIE_DETECT_QUIET_MIN_DELAY(delay) \
> > +	 (((delay) << CDNS_PCIE_DETECT_QUIET_MIN_DELAY_SHIFT) & \
> > +	 CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK)
> > +
> >  enum cdns_pcie_rp_bar {
> >  	RP_BAR_UNDEFINED =3D -1,
> >  	RP_BAR0,
> > @@ -292,6 +300,7 @@ struct cdns_pcie {
> >   * @avail_ib_bar: Satus of RP_BAR0, RP_BAR1 and	RP_NO_BAR if it's free
> or
> >   *                available
> >   * @quirk_retrain_flag: Retrain link as quirk for PCIe Gen2
> > + * @quirk_detect_quiet_flag: LTSSM Detect Quiet min delay set as
> > + quirk
> >   */
> >  struct cdns_pcie_rc {
> >  	struct cdns_pcie	pcie;
> > @@ -301,6 +310,7 @@ struct cdns_pcie_rc {
> >  	u32			device_id;
> >  	bool			avail_ib_bar[CDNS_PCIE_RP_MAX_IB];
> >  	bool                    quirk_retrain_flag;
> > +	bool                    quirk_detect_quiet_flag;
> >  };
> >
> >  /**
> > @@ -331,6 +341,7 @@ struct cdns_pcie_epf {
> >   *        registers fields (RMW) accessible by both remote RC and EP t=
o
> >   *        minimize time between read and write
> >   * @epf: Structure to hold info about endpoint function
> > + * @quirk_detect_quiet_flag: LTSSM Detect Quiet min delay set as
> > + quirk
> >   */
> >  struct cdns_pcie_ep {
> >  	struct cdns_pcie	pcie;
> > @@ -345,6 +356,7 @@ struct cdns_pcie_ep {
> >  	/* protect writing to PCI_STATUS while raising legacy interrupts */
> >  	spinlock_t		lock;
> >  	struct cdns_pcie_epf	*epf;
> > +	bool                    quirk_detect_quiet_flag;
> >  };
> >
> >
> > @@ -505,6 +517,9 @@ static inline int cdns_pcie_ep_setup(struct
> cdns_pcie_ep *ep)
> >  	return 0;
> >  }
> >  #endif
> > +
> > +void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
> > +
> >  void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u=
8
> fn,
> >  				   u32 r, bool is_io,
> >  				   u64 cpu_addr, u64 pci_addr, size_t size);
> > --
> > 2.15.0
> >
