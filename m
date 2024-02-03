Return-Path: <linux-pci+bounces-3061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7128847E0A
	for <lists+linux-pci@lfdr.de>; Sat,  3 Feb 2024 02:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16B081C224FC
	for <lists+linux-pci@lfdr.de>; Sat,  3 Feb 2024 01:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B8B80A;
	Sat,  3 Feb 2024 01:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="e3s6n9b5"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2079.outbound.protection.outlook.com [40.107.13.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7391E7F4;
	Sat,  3 Feb 2024 01:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706922336; cv=fail; b=N4edR6oiVnvSxfJHZ/BvZYobl8lWYh9BmyTpq/lcdcDgVpirtQPVptTDKuZf/z15W60nTsuELu0XS3+mKc5hSu8yU3L+phYLIgg8u1HbPhySfDYbkeUavTph4cUgO9fs7lTstI5vbP9N6fNbuiXFlZifLRMQQZTLS2WP4NZtsl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706922336; c=relaxed/simple;
	bh=EJ7M/7YplNivJFC7z+3uL4qPeGqRX+1uY2+uFNGLQJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o7AtvUqSz1VcUeIsNBBTBNM0pmvh8+NGWI5MlLw4tjXKqFsSJTkKOXVobCN0UPybYDvvGOr1bXohUJVk74ip847m+lCUtWcjkeLEAFydRxzY+5es6WLUOutedcIceWkgutfAzCVCJMnCkDw5UPNJ6NErjSHL1Xi8GNBJEGwfp1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=e3s6n9b5; arc=fail smtp.client-ip=40.107.13.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pe095bEz6uQin9RtoN7BrHBNBJmofyHevWiWT6klXEaQ/1m74qMI8oQcGyKxKzq5uXb/yX4GW9rFEiLMI23MPqk/L6dDrzJd8ATYa9CYqtefljhdLhUFtt5AGuhh/+o3R86CGBaGFQcRxVDXyHAHTr5S0wpyVFUePgBr/s2wOvLCcEJr824UCBRccKPT0RBeZ2NBk+5oIwr/39n7MOFXZ16WmzHMa86QbYgbkw0g90qbrO02G3WaqL8RFEkuLpVBC0TL2xZonEhqRL7GIqG/SrKDKbONhjGTtv0qOu/VEds+imEMrQMLS0+ccQXrTyqHrLDzqGYX4l0w9U9q1j5iYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5S+ozEGjviT/h4Tt2DAy+611WT9ZPwMuLIIUyrk0vTI=;
 b=QkFeVkDRu7jJbtqW9ggl7XSqhIdgo2IPHvB/MtRaKsRnfobjpjBpD5FMrH9/V6ad040uEcF8qI7NHiBxIEBqLVK/3tWDQR7SMBjhurFTFj/XvUdshODrPu3yYaeQ6c2stC14sNLLLWcS8huclN4gM8pJEc+lh+p7vchuKlaD3HX+KDZrf5a6Emh57Z0cQPPfvD/CGtuNlCfLj57aqxHJgGBNQb9HvgK8o5WX8cEs57pVOjhvPv9sDWj6zeh82dTmDBqVQP/jm+wcNgAMPOjsFQwcXp46HB3zYZKhRlSPBC062+oSsbuQveB5zMzAWUpUQklS9FBemT1KdB2H7CyzQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5S+ozEGjviT/h4Tt2DAy+611WT9ZPwMuLIIUyrk0vTI=;
 b=e3s6n9b5mHxpma2dFdj15fRDzPPFl4z8FZBlQxS5WgIYLGBIT4ZOOuyuaYbJJZnZV4B1i1IY4YzOGd65SzY28sGRo73JyUPuNCfHIeaNyihCGfGtrgjXdgF73vs14Q9rz8fze8qpPAOl39A/+p+BNeNU9bTdDW0p4tZvfxlq4M0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9350.eurprd04.prod.outlook.com (2603:10a6:102:2b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Sat, 3 Feb
 2024 01:05:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.027; Sat, 3 Feb 2024
 01:05:31 +0000
Date: Fri, 2 Feb 2024 20:05:24 -0500
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH] MAINTAINERS: Step down as PCI ENDPOINT maintainer
Message-ID: <Zb2RVNkL+AkvqXWq@lizhi-Precision-Tower-5810>
References: <20240129165933.33428-1-lpieralisi@kernel.org>
 <20240131150116.GA585251@bhelgaas>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240131150116.GA585251@bhelgaas>
X-ClientProxiedBy: BY5PR16CA0022.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9350:EE_
X-MS-Office365-Filtering-Correlation-Id: c408db53-1ffc-496b-00b0-08dc245437c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2vAubASG1Vk+eAlOREEoIi0tD/wQ0xj8FUSWj8DQrWV7d7Gcq1DHH2EwFgl/Wani5GNbzvR9H5xayKkwdIxdzvgD2RS1y+M1jXTbwlHoMS/L6Y9N93NK9iFgvA3fNMuP+P5M8cvhBibGQ4YDHRetcoo5UHGpe8IfcLpfgadtABpSpDSIbayJC3eeeRPUd+rla1SEDfll5qZLWNzx95owyoZ04HRCIOfJezp4Dg9ZGV5LRyyGu1cY+614u7BUbNcU2OARLorJ0tBT3WpPKbMO0hsD7kk5miDwJnhFU5Wl2iz/Y9YhmMi4P0FeVp5/BAN+53C9+Jzky4BLQYd9jWoHpA5217JZdx7c0XujwHpf54tKG6j7XgtpE72Yq3J4OVw6yfWMjsnXUDPiYR3l3AhBcVZ2eOaMLNoJb7wUVO4Gm2SbJYEZWUtcLJ4ojUwt359kT5b7QXaPvH4nqtIn0NCwnSpwijIpYIjnAP+KSV+dMnyFkuUae1SulNpIv+lvlYYcVv+v+BXy6wlGwDV9pmN/blfcC2JGIqF7y8iHZnf2gV9cIqMOT2jfAg9aFoiaPyV0VkIV6YYIiOGPG/rsu9qhLg6/x15wUPFG4WjZZhL9MyUppTW8zle+MMc008oUZOj+tMEq1hpIgLTNBnUV8bB9Pw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(396003)(39860400002)(366004)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(316002)(478600001)(8936002)(4326008)(8676002)(66946007)(66556008)(66476007)(86362001)(2906002)(33716001)(38350700005)(6486002)(6916009)(54906003)(41300700001)(5660300002)(83380400001)(26005)(6512007)(9686003)(38100700002)(6506007)(6666004)(52116002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXcvclBnME9xRlVCdlVBOC80YU91YTJVRzlaTlorREVYRXZ3bUNIYU9xT1U2?=
 =?utf-8?B?a1h6UFFpNTIxYTZPUWdvTjNnUXpCcEpSZ3E5SlZ5L0VScVRIZEZmU3E3bXJl?=
 =?utf-8?B?b2J5TUZ4TnZ5aXpDeUpUMWN5enBneE8ycnJPV2F0dnNRaFI2bnpoaFlJUWZh?=
 =?utf-8?B?bHZvVXJtbDBHd280OUJBYzZlUHY5Mk5LckI0dnJ4bTh6aUljQjhDN1EzK29N?=
 =?utf-8?B?MURJR01MeC9VRXM2M3hOZTdMU2lkMm5pemNjajMwT2UxZ2djQk92bXpHK2tw?=
 =?utf-8?B?WitVTnNsREkyWmFXV1lEeHZCU1Z3YXB3SGNOdjRXT2lya1FyeU5Dc1dYWndO?=
 =?utf-8?B?RWt3MUo0SFVPUVA4ZGdWZDlEVFl2d3BwKzBGbG5qMmw1ZkdpcDBaNGpwa0c3?=
 =?utf-8?B?OHNyQ1ZJYUlDTml4cTU4b1pmaUVwZjRuVG5Rd3RubS9McTNLTmUrdzJ1MGpD?=
 =?utf-8?B?UkNrS0ZCb3VZVFdMdmlZbUJHZnNnUFFvQUJ5aTYwNzRuWkhPUWVmQUtTeDY0?=
 =?utf-8?B?NHNZRDBoaXZqSmtPaXl4SHY1ZlVpRXRoRnh5VnlNbTJuSDU3Q2c4UEtxRHp5?=
 =?utf-8?B?NEF1NGVkNzd3c1FEY3NhZXk2eHNBdHZzakZUZDloS3Flb25kd2RycVUxeGpl?=
 =?utf-8?B?YzBweC93SWFMQmtLY1lFTGQ0ZnZYZk9kRzhWd0h6WlovaUk3VGI4dzYwUG8z?=
 =?utf-8?B?cUpPU3hHSjN6ajZ6Z1Z6bkc5MWh6SUFNVHRwTm1mbW0vZXM1VzhZdlJJeTdB?=
 =?utf-8?B?Z0x5b00zcmlsNzFQTWVzZVJkNlFsMXRzRmtFdTJwVEJyNjQwME5SM25sVlB2?=
 =?utf-8?B?RFBpTzhwSHBNQUxzM1hrVjJyRUJtbm1PNmVsRkxPeHQwVDhqOHdBYW5NUFk4?=
 =?utf-8?B?Y0dCdVhGcmw3cFlLUkdBVHhDNnVIWTZwRXpSdDJGdStCVTRxKzlMRXFPTndw?=
 =?utf-8?B?T1hGMGl5VHRzTzBRUEpYUmprd0xtTnYzMHlmc3hyVi9HVHlEQjRhcTFyMjFn?=
 =?utf-8?B?L0J0MDJycis2K2pOdlJTNjFxU1RpQ08zYlNZUjQ5WDBnUmZ6Wkc2WC9lTFEr?=
 =?utf-8?B?dUNFdkpaVnJzUmYzZFVDeVZaRkFQVy9BSm5kekRZbm00VU9sYWxKb0VqakhT?=
 =?utf-8?B?aEJrZ1dnSVlucTZjalgwQTBOd1h4eTJxOUIyaVlmNmFZck50dGZWU0hVUFJo?=
 =?utf-8?B?TTlFTytINzQrQ0RiSmVlbkNpU2tBamJpRE9ZdDJKbVM3UjhybU9jQlRqa09K?=
 =?utf-8?B?SFFqODgrN3lCa0VTazBYMkZEYkdIZVMzdWl1RFVocHVsYjJKSkYwMlBTandt?=
 =?utf-8?B?cE5maEovbC9MSHlaM0svbnpkbXF4L211YmJZUHRFWFQyc1o3VWZqY3lVQlVF?=
 =?utf-8?B?aWNjSEZlUWJ3ay8yeGlhTk1rbGc2eUZacDZRSVNhK3BZSVNaRS8xM0VtREoy?=
 =?utf-8?B?d2RtRUZNUHRPc3B3c2FjUUtGMUJYNHE2M09IR01UVkw2TkJTaUFJOVVmS1Np?=
 =?utf-8?B?UGpvMGQ4WHg2aW9lZzlzU2xHQ2lQdndrb284aW5VOFVhL1FTZUJHd2ZrMVZO?=
 =?utf-8?B?TXdKamhCbThXRG1Wa3NSbDJkS0ZaakdpZlhIbXUyaXk2UEZoaERBcmxINlpL?=
 =?utf-8?B?dXgxZ2RYNEx5UmdwcEVSdEhGTWM0U3Rudmt6ckl6aERNRnBnU3l2SVJLcmZO?=
 =?utf-8?B?NTlNM05QdU5hRS9la3R1azAzWGQwajNtKzVCMzI5c1NuODRaa2o3VHFpQTFQ?=
 =?utf-8?B?bDJXeFJoTHQvKzNhOGhKWFd0SUg3MzhmQWtQWDZ5RHhxcVFlU3hlWWJWU01x?=
 =?utf-8?B?TWNBeVp6S1RuQ1FVb2ZZN0dXQ09OZXlLUVhrSjMxeDFSR2JGeFkya2NpRzA1?=
 =?utf-8?B?NXEyWW9JYTFHZkFBN3I0MllYQklac0QzcWZyY1ZLNmg2R2g2VXYxZFh0V1BI?=
 =?utf-8?B?alcxOE94SzlRRDljYmZaWkxYU29QUjMxeTZWL3VUbnhnZUFYc0JlbzB0ODQ1?=
 =?utf-8?B?blJOQlA5YmJGMXltU0REOTQxY1lWYUMyOU8yMEgrTEthMnB3TUl4dHBXOWJE?=
 =?utf-8?B?M2gxbWdjSXZPTEFkRUREVWxZbDd2bnZkRVRtYytuRFUxQkdhc0pFWjFUb3Mr?=
 =?utf-8?Q?u3BTaiaHF2EQzHD1KmXEdRwri?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c408db53-1ffc-496b-00b0-08dc245437c0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2024 01:05:31.1953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLZydYIKKv4zin5XNS5j6GP+g7PdwZNu1GXTVb/PLADsKh9vjzC8QX1plNnIqqfUnlod89VvPh1q/AqRQ21LbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9350

On Wed, Jan 31, 2024 at 09:01:16AM -0600, Bjorn Helgaas wrote:
> On Mon, Jan 29, 2024 at 05:59:33PM +0100, Lorenzo Pieralisi wrote:
> > The PCI endpoint subsystem is evolving at a rate I
> > cannot keep up with, therefore I am standing down as
> > a maintainer handing over to Manivannan (currently
> > reviewer for this code) and Krzysztof who are doing
> > an excellent job on the matter - they don't need my
> > help any longer.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Cc: Krzysztof Wilczyński <kw@linux.com>
> 
> Applied with Mani's ack to for-linus for v6.8, thanks!

One question:

who will pick up endpoint patches? 

Frank

> 
> > ---
> >  MAINTAINERS | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8d1052fa6a69..a40cfcd1c65e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16856,9 +16856,8 @@ F:	Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> >  F:	drivers/pci/controller/pcie-xilinx-cpm.c
> >  
> >  PCI ENDPOINT SUBSYSTEM
> > -M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
> > +M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >  M:	Krzysztof Wilczyński <kw@linux.com>
> > -R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >  R:	Kishon Vijay Abraham I <kishon@kernel.org>
> >  L:	linux-pci@vger.kernel.org
> >  S:	Supported
> > -- 
> > 2.34.1
> > 

