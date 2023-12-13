Return-Path: <linux-pci+bounces-882-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4AE8119FC
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 17:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 287BDB21052
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 16:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D431B364BA;
	Wed, 13 Dec 2023 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="snloEPjB"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD40D0;
	Wed, 13 Dec 2023 08:46:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mowc99NtHz47QLKdjiBzEvOMcXsXa4/Vr0X/2GBvL2uOxnTF2DPv35C5i8RbcD/OJydKWziLyk8EekvoAKD3f6J0Lh5kgwu+pLssJptM2CStDvZw5whsebSnn/wDolcNurlrx7mNbh3UtR6F606GVEiyICZnZO6ZyRpbw4HzJ4drBPnKO7Z2FOEOuwicdD1vbE0FKkS78lLBvffUpSKWjDiCqQeR9ctFWyySFObDFf3/8mhb97kfBRhO7b00y+//6Q9q4bIZVL6+LjQuM9FURNl9JhFkLE/1voNgehlKsADfquEsA6sHVPLls+ddkSDl/iM3Iar35q+nXoHWiItWJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNB7bRzLd5iMaSu8kBuGdZDtr1yGJg+cwbxar1W8oDA=;
 b=RHHDIH4IjtkmcG2RhisMaZJLT6vAPLf5Ea2k1kGnY9Boa5e3NMK75BD1wAefswucM8DFeeCXlXpXtOpkztJ1Gg7RUxJb76SkXXQ5eJMvYAh1xrvxYdUGpBcU44qRIdCia37aWibQvSbTDvOG2xDOAoQuvdN924ARM7NXG6hSCmwyNQmNGKE8HnqCYM2GYyoX31niw1qcsa5A96kYCvwAnTj+Dwzxa8xl8qUhuVujs7Wq8ERUjhdf+2J89Ub9kvbfmRUVhTeGO/KmCvZgN7fHzL4YNxoY4VLF77Q6zp1BzTbqURS7cnZXSSVkFunAQ1O3ZiP3UfrdBJPyvbYap4UCUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNB7bRzLd5iMaSu8kBuGdZDtr1yGJg+cwbxar1W8oDA=;
 b=snloEPjB4Wo4TCcGOCfHF5YG8T/3N8eBEtDpoPiRK3KX6Pz/eGYqxukiuyUsjcPqRqMJuQFkTpfFDA7d5stEzWeYnC/qEaK95CYKa1StUSqBD3a5sllabO+de4tAVFIr5jaP494NphV2AQzPH30aq7hah3wqd8igqldWZngy3eE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by PA4PR04MB8061.eurprd04.prod.outlook.com (2603:10a6:102:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 16:46:35 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 16:46:35 +0000
Date: Wed, 13 Dec 2023 11:46:17 -0500
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: bhelgaas@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
	festevam@gmail.com, helgaas@kernel.org, hongxing.zhu@nxp.com,
	imx@lists.linux.dev, kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
	l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: Re: [PATCH v3 08/13] dt-bindings: imx6q-pcie: Add imx95 pcie
 compatible string
Message-ID: <ZXnf2f8C2i2TFVBh@lizhi-Precision-Tower-5810>
References: <20231211215842.134823-1-Frank.Li@nxp.com>
 <20231211215842.134823-9-Frank.Li@nxp.com>
 <20231212224426.GA2948988-robh@kernel.org>
 <ZXjsq2QtFa2V0BAl@lizhi-Precision-Tower-5810>
 <20231213143615.GA1093782-robh@kernel.org>
 <ZXnQKBnweCT+si6/@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXnQKBnweCT+si6/@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SJ0PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::6) To AM0PR04MB4834.eurprd04.prod.outlook.com
 (2603:10a6:208:c8::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4845:EE_|PA4PR04MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c02e721-99f8-44f3-7c9c-08dbfbfb10ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rT1wxvPi/D7Z6LCMgPXyJEq/MZgabvNN/82c7GLC4FF5vXOfOGJL2Jst5t2SL/7SY5ipPe9Dngf7VL4zzwq3SpFtffZF/WmTvXFB9wgXGwp2UItGdu8j6Cj+t7sTwBZ752PTeUBrhwXUL7wQTHrgBw7MKBeqW+PBPI1dt7vG4qeMz0QeaKYBIBY602Fv2oUnLbTi+fA6r/N+NGOBHjW+Ex5+z98HQfDK10KS1DV3Lm/1SPOys8IxlOiGC6aT9Vt8uW+rlr31WWte/owY3OuNGk/axvwcRzB3HoVMygo7U1mTRM/yPTor6soNoycOVVRXUYfTpqEjwH6/PfMtF+Q7AyppZJVD707tqYda9mgIZPGGbXn845VAigyHigagPS88+ANNFswJpmHk/kkXVyE5g2Z+N63+LoDtV1jyLGPAyt3sbT7/2pjdTDTYOTthLFInhQgnWisZLhu18c/VmkJrWVHTtVhFCSWGJdk80lRV4Cks8Ea01CcTV21QE6ap+2c7EatT/0CBMwQiK5KkDTbwYENIDd7MOyrO4gPS6cutV8H3+lKJOJQx0dqUZXKu3v6qXIMfBQFvybhj/VHWZtRF+IMtMyfW6PEpRzVvmp+YhpRRJPJ+zI5KZQNtI6mxv6wtiLZ9jkmKm/Ik5Qj7zcbk+ZDCenQ2qHThu4M3PGQp90E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(376002)(39860400002)(346002)(396003)(230173577357003)(230273577357003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(478600001)(6506007)(9686003)(6486002)(6666004)(26005)(52116002)(966005)(6512007)(33716001)(7416002)(66556008)(5660300002)(6916009)(41300700001)(2906002)(83380400001)(66476007)(8676002)(4326008)(66946007)(8936002)(316002)(38100700002)(38350700005)(86362001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rOmK5wroOmcrdhzrVKOoEXXq5FEA3urPIudniVA50c8E3i9FGBbjJi7R9XZF?=
 =?us-ascii?Q?ZjkD1919G1oPmy6ax2xjHZeSkIHyb8VzAHAfZ2nxiyt4gpQk44tCPvWSOxJ1?=
 =?us-ascii?Q?rKU31h0DtLzr/ZtjRBXTNKwC2wM+nywIWi9vFO5SHaJMWt057GVQf2oRlLft?=
 =?us-ascii?Q?FiOGxVR6jXD9ol/C2f4cgijfJKV2rckI7N41H8AxtXdVdn4rpvT9HuN6uRhT?=
 =?us-ascii?Q?WGhZ1f1ZCgmZv7L+ishn6arNCgTlf04F/HPmKCoJoPNprOP4aehEZrUnIEDq?=
 =?us-ascii?Q?wnR9dXCYJ9KPktkkV6RWukF4ejQkFQGdV2BbIxbaewUTHRd81+xxqiThf+mM?=
 =?us-ascii?Q?ntqG7HGBDCRx8CC6Eh9OPROuZICodJVSLYSi+7vtEpyV1q3BiGuveXDFawIv?=
 =?us-ascii?Q?nl9X1s+MpmyzZs5viuuU2ZXv5JAnzKcs9RACAZv3mDrWb4TKOF6d8y5sbdBj?=
 =?us-ascii?Q?vLYaKfjnDQCFklDVktgIllQ4MKYZYcjIQPHYU15Hk2z4y2mqBvhWfXPQ1uhs?=
 =?us-ascii?Q?nFDMgMugabxEtPSDbz1USn3hJV3Qgn827gebWMiDZGh7Fjd+pqciSR28CRY2?=
 =?us-ascii?Q?kRgamIKOYH7KVGAbEg9aggS9TKVDtYBYYQ9GX1AUjVGkGJMW+jugaa9M5pYD?=
 =?us-ascii?Q?ce6fskgxEQU1nc0sRL4lDwiDlWF3iEiItcxaTQYEnp3c0KGWR2YqelohufgR?=
 =?us-ascii?Q?d3ZBXF0w0C1G276jVpY/n2tkZmnPqMd+6qFOBoJHNNQdhFnBOsJ35rxzkqHH?=
 =?us-ascii?Q?Jg0Lm7mSwA6Qka8y8cEZUcogLQCCbrQjJCSSZFVV21mT+UcvaOfy6M6PxLVW?=
 =?us-ascii?Q?d3AFKqAai+egy9UYbYErwLq+dgwO35SX2w3m9JFswLnUoOWednS0cMRxg+us?=
 =?us-ascii?Q?6CEXPXdFnKp79uvSh/PS4wkBwB9J1D31kTnJRuuUWjrVt8ql41OpsNxNdpRw?=
 =?us-ascii?Q?4nuuEvieUKd+oTFPHXqJg7bBKQrFCl+0Y/4AJ400aRwAMRNFSLf3V4KdeRf4?=
 =?us-ascii?Q?l2YH6UzWSgJNkYpQGnvrzR/ykJZkakPJjza8u5SrA9RIraArq+OjXh6eApyX?=
 =?us-ascii?Q?7iyWe2aFWSUf1jryotjTy2A5munnEBHWYF7Anuek6DO7bwyUO16fPovYlvs4?=
 =?us-ascii?Q?yrwJj1pfq94ifJHUF7KZJyhBGQ/QnJI1plKdy13swaWPuAL5srClwatmqYzI?=
 =?us-ascii?Q?JgSB+DmPGYQxnoFgtS6ZT3DI4xhdrk6+qCiQ4vUEzraT2FoGQ+jPd4J2Eo43?=
 =?us-ascii?Q?SmQ2ZM+1Y14IHx4TeW93gz42KLKhiIIVFd5asRIg5VF8YDCcibTqGSrHL4t3?=
 =?us-ascii?Q?Q01ogWmtCqPbM13/wGUKrDo9llN/I3kgBA3svyqcRkzMTb1TGRdWQMMQDrhv?=
 =?us-ascii?Q?BysnPV0MNnEMihuCyAebCybyYcrAxe8ew1UxJsOY7pgdo997LvDT4nGmWLSu?=
 =?us-ascii?Q?76sJ2m4BALFCgVD+2wyq1ms6/KYjZLC2PrRFm1FkrTkOv5v2bsvQjaqx35DM?=
 =?us-ascii?Q?drQn2NEEqGKNJ8B9ufK/ga7qgvkumPYlhj+tdw9Wl3+m2zah3mB9sVjYs9ng?=
 =?us-ascii?Q?SLqnyA4liYaZqZ8i54y+o10RGsBm5yoMD+EPXW6D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c02e721-99f8-44f3-7c9c-08dbfbfb10ba
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4834.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 16:46:34.6079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5k9hAZ2lEt+0AtyEWqpd0JILNaAxCg5snLVNKn8oNj3IVofHgREvlrRdH3XJombdXMzQKW2nw9IsMq009wc4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8061

On Wed, Dec 13, 2023 at 10:39:20AM -0500, Frank Li wrote:
> On Wed, Dec 13, 2023 at 08:36:15AM -0600, Rob Herring wrote:
> > On Tue, Dec 12, 2023 at 06:28:43PM -0500, Frank Li wrote:
> > > On Tue, Dec 12, 2023 at 04:44:26PM -0600, Rob Herring wrote:
> > > > On Mon, Dec 11, 2023 at 04:58:37PM -0500, Frank Li wrote:
> > > > > From: Richard Zhu <hongxing.zhu@nxp.com>
> > > > > 
> > > > > Add i.MX95 PCIe "fsl,imx95-pcie" compatible string.
> > > > > Add "atu" and "serdes" to reg-names.
> > > > > 
> > > > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > > > ---
> > > > > 
> > > > > Notes:
> > > > >     Change from v2 to v3
> > > > >     - Remove krzy's ACK tag
> > > > >     - Add condition check for imx95, which required more reg-names then old
> > > > >     platform, so need Krzy review again,
> > > > >     
> > > > >     Change from v1 to v2
> > > > >     - add Krzy's ACK tag
> > > > > 
> > > > >  .../bindings/pci/fsl,imx6q-pcie.yaml           | 18 ++++++++++++++++++
> > > > >  1 file changed, 18 insertions(+)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > > > > index 81bbb8728f0f9..b8fcf8258f031 100644
> > > > > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > > > > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > > > > @@ -29,6 +29,7 @@ properties:
> > > > >        - fsl,imx8mq-pcie
> > > > >        - fsl,imx8mm-pcie
> > > > >        - fsl,imx8mp-pcie
> > > > > +      - fsl,imx95-pcie
> > > > >  
> > > > >    reg:
> > > > >      items:
> > > > > @@ -90,6 +91,22 @@ required:
> > > > >  allOf:
> > > > >    - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > > > >    - $ref: /schemas/pci/fsl,imx6q-pcie-common.yaml#
> > > > > +  - if:
> > > > > +      properties:
> > > > > +        compatible:
> > > > > +          enum:
> > > > > +            - fsl,imx95-pcie
> > > > > +    then:
> > > > > +      properties:
> > > > > +        reg:
> > > > > +          minItems: 4
> > > > > +        reg-names:
> > > > > +          items:
> > > > > +            - const: dbi
> > > > > +            - const: serdes
> > > > 
> > > > Did you test this? It should fail because 'serdes' would need to be 
> > > > added to snps,dw-pcie.yaml.
> > > 
> > > I run "make dt_binding_check DT_SCHEMA_FILES=/pci/", no error report.
> > 
> > Only because you have no example. What about your actual .dts?
> 
> I see. 95 is quite new. Still have not good base yet.
> I may just take take care this session.
> 
> > 
> > > And PCIe function can work.
> > > 
> > > > 
> > > > Is this really not a separate phy block?
> > > 
> > > This is misc block, which included phy and also include some registers
> > > about SID for each PCI devices. I plan do it later.
> > 
> > Sounds like it should be a separate node and use the phy binding. Do it 
> > correctly from the start, not later. Later is an ABI break.
> 
> Actually, I considerred phy binding. The major problem is LUT (look up
> table) for MSI and SMMU. LUT need be config according to some PCI device
> information. I have not find good hook for that at PHY driver.
> 
> > 
> > What is SID?
> 
> Stream ID, each device master have SID, which pass to IOMMU and GIC ITS.
> 
> Frank

Similar case at

commit c6523c4a301d3adff7ddcf57515b9c847beb7566
Author: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri May 6 18:21:02 2022 +0300

    dt-bindings: PCI: qcom: Specify reg-names explicitly
    
    Instead of specifying the enum of possible reg-names, specify them
    explicitly. This allows us to specify which chipsets need the "atu"
    regions and which do not. Also it clearly describes which platforms
    enumerate PCIe cores using the dbi region and which use parf region for
    that.
    
    Link: https://lore.kernel.org/r/20220506152107.1527552-4-dmitry.baryshkov@linaro.org
    Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    Acked-by: Rob Herring <robh@kernel.org>


+            - const: dbi # DesignWare PCIe registers
+            - const: elbi # External local bus interface registers
+            - const: parf # Qualcomm specific registers
                      ^^^^

+            - const: config # PCIe configuration space

Qualcomm called "part",  nxp call "serdes"

Frank

> 
> > 
> > Rob

