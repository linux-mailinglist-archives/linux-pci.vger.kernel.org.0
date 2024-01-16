Return-Path: <linux-pci+bounces-2234-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A4182FCAB
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 23:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B6D28F50D
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 22:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FE92030B;
	Tue, 16 Jan 2024 21:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YyNyO04Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866A1328C1;
	Tue, 16 Jan 2024 21:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705440566; cv=fail; b=P1loS+93QJsHd1RGFBKuM7e9So3WFyoJv1g+xwsUL7WX2MOriwOhi4sSO3+TJJFtQ5AM7TV6fjnR4PL0twV5ASt9DksBsA2fAFWZsfnJGt2cKZW1IYfKqTC5H0eR2DCNiZ5mgoYoP2XQ2PC7vic1X/KyOvdIGAivBroXbn6NBJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705440566; c=relaxed/simple;
	bh=s6+i/9DAO1Tmq8AI67YfFZqpizr7+3eL26IAiAXtjkE=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:Received:Received:
	 Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=SYqRa5goI0Rs7AWJQFBTQQg4reTWiA8FvZ4DrGnK2kAN/co4+16i3KwFSfNvqOya68SzABNnfcaDeNdcYCw0frwmMfb0AbMnVjDOo/WTaBJpERkFQ7Unv/Q0McxWKkHB+GNJbhTXrFwilCau0MuRu+lABUa/D4Gq6axpTGB6S/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YyNyO04Q; arc=fail smtp.client-ip=192.55.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705440564; x=1736976564;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=s6+i/9DAO1Tmq8AI67YfFZqpizr7+3eL26IAiAXtjkE=;
  b=YyNyO04QGdvTcz8gzD6bkKesIqt6gcVEuEoq8dN+/oWODwcP59TXGf99
   c3Ldp/FIA9k9DIuh4htvh3W+ThH66Z2tCE/X6cfs6yhTn1AUluXGXWHp5
   AnM63fDQWA2J72CB845cggtLm2UX6/BncBlc1UJrky8a778jyA5z30k3y
   no6++/+W13FRRfjyx9utqmq9HVeVYvTLMPpMkZD8cn4w/kVI/LBRkO3fa
   BJdHQusmWZ+PI2BbkSw29FuaCckIqtIV6SWnAsWZ/EQyXBZ0daENHhOB+
   ndsFElKvnDomlAW0lxiv+pjiW9JbnFUjtNwYGEuk+9ZprbXQGGrmQF0V3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="486149968"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="486149968"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:29:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="787586898"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="787586898"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2024 13:29:23 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 13:29:22 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Jan 2024 13:29:22 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Jan 2024 13:29:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2jTzcv/n7cp67POXf8hrenR94qzZo5TYMACwEIJfaK6q/aoGKs++as1mHj9aqUygG5bWqRVZmTJ/huqKHWhr7Ri0mVUSbj6YkDpfUuYT+5VLI5NzvdR6q79hxMjJ7UAc7hvN0SrsYU2Xr0HD1PDxH7kMdJ0dC+J4Hdr9SiTWy75bxv2E5Er3l0fExrvAKt8BVx9+lKBIaczUuuD5OCGaiFmWkxOUH77vvIF978+NuWZMaUDcruGa9oG+tfGY9oYKxZz3ouXNeZ2745BIIALn+uk2bjiAk1eRRJlm1vlxlDxtklFuF5WUOknkh6bwZGRCsJ4CzTxyIKn8tSs0lv/Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgsWB103nGTqBz8BuezxKKw+7BBPbMfUkumWRu3dd4Q=;
 b=C2N5SZgDYU2KqVqdECen0AS6qOp33se+71q6foUUpltK/lTLV7sxFJNtxKZrw9tbypVUQo+ZpBZ9mfwFfFSsYvVnB/C1aVvp+IvsXXfSVhyrsmsQ+iNT4zQGh7EeE1ZRp+3wJY7JBSgXDz+qZNsXHj5H5n7P71MEuza+N+VNbkN9jE5EJ7IwWefJLj8DoDP07kgqLEO94e8p+p6iomP315ZesBYA1XUf0mJIOpUWmyt4P8ClFgcVIrB+xYn00tWIEMCLpbMgDw0ditJFCvkeQFzxr2HykAkCSxnQ32CNwJXEw5G9EVQmrjEZ/+GdEcWrdDa47hH0B1kkXr1Y7jjLeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6113.namprd11.prod.outlook.com (2603:10b6:930:2e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Tue, 16 Jan
 2024 21:29:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Tue, 16 Jan 2024
 21:29:20 +0000
Date: Tue, 16 Jan 2024 13:29:18 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>, "'Jonathan
 Cameron'" <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "Yasunori Gotou
 (Fujitsu)" <y-goto@fujitsu.com>
Subject: RE: [RFC PATCH 0/3] lspci: Display cxl1.1 device link status
Message-ID: <65a6f52e5724d_3b8e29410@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231220050738.178481-1-kobayashi.da-06@fujitsu.com>
 <20240109155755.0000087b@Huawei.com>
 <659f404a99aad_3d2f92946e@dwillia2-xfh.jf.intel.com.notmuch>
 <20240112112414.00006443@Huawei.com>
 <TYCPR01MB11764763DFE894B96EF0C6C38BA6C2@TYCPR01MB11764.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB11764763DFE894B96EF0C6C38BA6C2@TYCPR01MB11764.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: MW4PR04CA0152.namprd04.prod.outlook.com
 (2603:10b6:303:85::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: ddc0b92a-0709-4a23-17b7-08dc16da336a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IoG0Jdaqk8SKgJQmpYVBljlPMOjO+qd6zdI9aPCFIEXi5ISAfJwznOWKOEvlH+2zOApLuF8jKRCFJd2ES9QLO3wJ4OFsxlyvtImWYoxCHObzc6yVngBPawCcGfIH2PiJHfy5JDwgdp1S6yZQtnZ78Tuubc6H0IRSv2tS+/JCkKPtebFfGWkpIsXlqAxEtAayGEDjuTAnVjEXKt1CpTeRi4E2O2Vs8LM/f2g1AObBbkMAeErFhYKo4kBt8NY776V7Jp1l2fEheIUkgeT1L04n2oTbPtpPzFiYLN9Hf7/D45tTBic+a1escl+2dIxXETMvZ6z6Xsv7gUoQnTGNUOQikl6HnHqfWP8LYp1+JWirLEbklIjBF0RyN1+Lf7E6r2/5WdtRkelRweMx62ESf0NfryR2mkiDMSAIrfI4jjXxP4mcz6hvBHCeAUZbxkd2X5e/bQ+cS6qG6CYSxdBAGiTvvK9c1F4/sBiHmrV6FqGw84l74ap2XHqAmpWTZ/HdGhe6NvT6RaHvdV58p0R2qL9K4lKIjYZjsJ+5FqwM6wFAOsxrfCpkSLCtatlPrRh/v0Ew
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(136003)(346002)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(4326008)(26005)(5660300002)(2906002)(6512007)(9686003)(6506007)(110136005)(66476007)(66556008)(316002)(66946007)(8936002)(8676002)(6486002)(41300700001)(86362001)(478600001)(82960400001)(38100700002)(83380400001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1e85dz3buuw4RLaL6BDsnWp1vAkrSpuQMiRuF9UU+vxJjNMZCEW/Rq/4X9wO?=
 =?us-ascii?Q?q+TuO6yiGVv3W5g4ow116QBtHMb7yitIeBaQj5vzvsfEr3zm4ehDkHYS6eF/?=
 =?us-ascii?Q?BSkRrcnZqgTWRPACdpOB1iCB/qmh1QHAjE2ttx0pEaI1kKHb+COHUKkVCha2?=
 =?us-ascii?Q?7mobLplcv0tBpM0WcvR3SBiD9zfR9NK+DsYSkvU21jY445zmjhVI0c9qvIMU?=
 =?us-ascii?Q?VDiUQB47/e18h+MUWQ+D9gkWhTJOtXzmuCW8yf1IwvoEjszoLw/bs45QF3k8?=
 =?us-ascii?Q?ERpauRdjZmlGhXB2MyIJV3zZILnSbDpNH9kuWvGvnvwvkFrm3xJnNTwufqvX?=
 =?us-ascii?Q?2MtTu/mApDjRj6rsUmptytdawS5diQ+HNX4bwUjmUZofkhFWW9Ztmm1NE3++?=
 =?us-ascii?Q?7UGfDY+/8ErOzVCJi10zMiY2+hz2eTyN6NTvfdyd9d/RT8/qk3kuBwb3fbGP?=
 =?us-ascii?Q?E6P/EjZL0i/XOfvyuTIpRfQn7vtBAKq+vCp7vwZ+QMj7CHtwAcPAD/c+Zgu2?=
 =?us-ascii?Q?Dq3QiPFIcRE9khEJ75bxSjdNScVUrEovAUD++NaYfydoCLwMirdaMnHzpn1x?=
 =?us-ascii?Q?Br3k6fJ+tLMrgqyEX0Zbsxzkw8DXFBjyuEAxZpMX+35tVNqEPNj3f0ztBr2m?=
 =?us-ascii?Q?vi9mn5AvasJKx0s6tpq1oZ2wgUolcmXgv45QK4jbvFU+XGDy2EA8JmoLzRwe?=
 =?us-ascii?Q?zReEnEXzD+xFCczdmRvMRr/eftxWa5RKr3KUr22GJErcGJIoujCFXA9elTIh?=
 =?us-ascii?Q?+3CjjSv0/2uc6CeABXbfU/1YvUqbzykPRmBdt3Yu8A1rutAmeGSR8IyHNkMy?=
 =?us-ascii?Q?ZD6Sgt4CpDjLvsaQJDgrR/swyqlk3trkvZ7Nh6HdXcuKFKMlGW2ghQYQv5am?=
 =?us-ascii?Q?8fKfgBbdzy/ozRb6GfzkD6+Qkxa2FiPryPvyN3uMjMj25yN51iTH3MXHQ3KP?=
 =?us-ascii?Q?UV8oPLN4H08y7wSlpTFHGDYGAohyeV2OQPdRB8rYx/YlX4nbTxjmuA2Ee1CL?=
 =?us-ascii?Q?ECkSaUirbalayiJUC7EPSCPiCxXXtw//QoapPYvPXhCDtf74YZPp09i4GqyN?=
 =?us-ascii?Q?r5/eZzYHoRzeJUa0jE1AoOjjP9sf61skVxCf1/lRXBkAIQC+Ej1luDvF4Lkh?=
 =?us-ascii?Q?ynU0UqklhwUab5QEPuiK31Q2x3qOAhZU5RmLvDvPP9//eDD8hnJrHaL1XVcb?=
 =?us-ascii?Q?2luximggikqdOC6oWlPYVol3Sc7AvzDHWZVf4YbIZ7sMoNWU1tyrVyMyX/pW?=
 =?us-ascii?Q?uzsuhsJntMsZU3uruwugz9LNt6BoGt1a0Isnw38jZjeIBDXkUEEml/j0klxe?=
 =?us-ascii?Q?mkvsanxg45zOOo6U9+BxrRE73GoQQsNOTz/lhyDFC6ZK6V4LmZwMzkdaJNag?=
 =?us-ascii?Q?6lIJsJ+7mAT9h5tv4ZdWnegBxGdVhHhCnjjEYyAtBvquNX/8bFxOJimmyTmU?=
 =?us-ascii?Q?yo9dN9LTAJLlTKkxmf4uAOwUBzu8rORXKeW/JCKN0ezPoHNqbqM3ZdsxVoYf?=
 =?us-ascii?Q?xGjN0uxpGEG6ctLVMbLPg6pV24bnsHOKhqmyXcA6+jY002xdA6DWw1/4JJrT?=
 =?us-ascii?Q?xortgJxe4mrxTDOOeFIw8EHjiONs5+jhs8UwzgNRwn/0q5xDmCwdeMiedr7K?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc0b92a-0709-4a23-17b7-08dc16da336a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 21:29:20.3803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbxUVIYcOV3qA6k7ndZzNZLJ0QvgK4WsQjIl+Ont+kJr8bgl8kDn2eAzeebFStmf3KKdLcXK3oNsZn2jiQod21kUsppQ6HqlrxKepCs5v+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6113
X-OriginatorOrg: intel.com

Daisuke Kobayashi (Fujitsu) wrote:
> > > I am wondering about an approach like below is sufficient for lspci.
> > >
> > > The idea here is that cxl_pci (or other PCI driver for Type-2 RCDs) can
> > > opt-in to publishing these hidden registers.
> > >
> > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > index 4fd1f207c84e..ee63dff63b68 100644
> > > --- a/drivers/cxl/pci.c
> > > +++ b/drivers/cxl/pci.c
> > > @@ -960,6 +960,19 @@ static const struct pci_error_handlers
> > cxl_error_handlers = {
> > >         .cor_error_detected     = cxl_cor_error_detected,
> > >  };
> > >
> > > +static struct attribute *cxl_rcd_attrs[] = {
> > > +       &dev_attr_rcd_lnkcp.attr,
> > > +       &dev_attr_rcd_lnkctl.attr,
> > > +       NULL
> > > +};
> > > +
> > > +static struct attribute_group cxl_rcd_group = {
> > > +       .attrs = cxl_rcd_attrs,
> > > +       .is_visible = cxl_rcd_visible,
> > > +};
> > > +
> > > +__ATTRIBUTE_GROUPS(cxl_pci);
> > > +
> > >  static struct pci_driver cxl_pci_driver = {
> > >         .name                   = KBUILD_MODNAME,
> > >         .id_table               = cxl_mem_pci_tbl,
> > > @@ -967,6 +980,7 @@ static struct pci_driver cxl_pci_driver = {
> > >         .err_handler            = &cxl_error_handlers,
> > >         .driver = {
> > >                 .probe_type     = PROBE_PREFER_ASYNCHRONOUS,
> > > +               .dev_groups     = cxl_rcd_groups,
> > >         },
> > >  };
> > >
> > >
> > > However, the problem I believe is this will end up with:
> > >
> > > /sys/bus/pci/devices/$pdev/rcd_lnkcap
> > > /sys/bus/pci/devices/$pdev/rcd_lnkctl
> > >
> > > ...with valid values, but attributes like:
> > >
> > > /sys/bus/pci/devices/$pdev/current_link_speed
> > >
> > > ...returning -EINVAL.
> > >
> > > So I think the options are:
> > >
> > > 1/ Keep the status quo of RCRB knowledge only lives in drivers/cxl/ and
> > >    piecemeal enable specific lspci needs with RCD-specific attributes
> > 
> > This one gets my vote.
> 
> Thank you for your feedback.
> Like Dan, I also believe that implementing this feature in the kernel may 
> not be appropriate, as it is specifically needed for CXL1.1 devices.
> Therefore, I understand that it would be better to implement 
> the link status of CXL1.1 devices directly in lspci.
> Please tell me if my understanding is wrong.

The proposal is to do a hybrid approach. The drivers/cxl/ subsystem
already handles RCRB register access internally, so it can go further
and expose a couple attributes ("rcd_lnkcap" and "rcd_lnkctl") that
lspci can go read. In other words, "/dev/mem" is not a reliable way to
access the RCRB, and it is too much work to make the existing sysfs
config-space access ABI understand the RCRB layout since that
complication would only be useful for one hardware generation.

An additional idea here is to allow for the CXL subsystem to takeover
publishing PCIe attributes like "current_link_speed", that are currently
broken by the RCRB configuration, with a change like this:

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 2321fdfefd7d..982bbec721fd 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1613,7 +1613,7 @@ static umode_t pcie_dev_attrs_are_visible(struct kobject *kobj,
        struct device *dev = kobj_to_dev(kobj);
        struct pci_dev *pdev = to_pci_dev(dev);
 
-       if (pci_is_pcie(pdev))
+       if (pci_is_pcie(pdev) && !is_cxl_rcd(pdev))
                return a->mode;
 
        return 0;

...then the CXL subsystem can produce its own attributes with the same
name, but backed by the RCRB lookup mechanism.

