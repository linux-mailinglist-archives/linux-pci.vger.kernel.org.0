Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2077C4B55
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 09:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344249AbjJKHN5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 03:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345630AbjJKGSq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 02:18:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9792B1997
        for <linux-pci@vger.kernel.org>; Tue, 10 Oct 2023 23:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697005012; x=1728541012;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=przElFPghngL5Bn4qJWiHxAB6NzmkSXDKRSMCJVlmIo=;
  b=EAkYLHKHevSFzzzGMEvqrgDKCDyWXx3c4xJ99fDsmMntuXq38+7l9SW+
   Qxocw8AzEKMYDzrASlIiGUHDXL0BUymYCXumezp3+iE70EQ49XFrpCt5C
   HFD7+W6zbD9bbo1UGqKjmqsRohT16wnrSC+cZjs6ZiLHiJY9RMr/1wtJa
   wkL9nr+WqEVPSZaYn5lCDwk8ghqZsucjrm6F391bN0PnluERDjH9jBts7
   ObzniJtN35OyWw+UYb5c2Sxlbc0b2//cvfGWBhpfvOOsPTjXWuOtNIIXt
   hSSZL4ypbt3cgaejGKVaD1D3rXRVYBQxVwu25tM0p3CMV4s3JxT4qneEF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="448790353"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="448790353"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 23:16:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="927442147"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="927442147"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 23:16:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 23:16:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 23:16:37 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 23:16:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONw9n8rJsjyDHw7kR6fNroi1FThgmVvv7E+/vXip3aDjX9mTqLzxm1nKzLnG7KadLXJ+wcPD9tMutdrnymyxU/lPNkQpy4umTuhWw/sXqC0Y7sO6zCroeZxF87RMGhXbSwdyF/4ro71paJ52pjTmKHHOniIPM0ZWYmr54w1Wb6GF/pBP4NJ7derl1s7V/KpeIIy39lHCwXDKITPhEXlDSWfHaaq3TLDvlacvuf363YT3jbCfNttJzTq+CO8dX/olowQXpwts07exg+8EWDyQ9QIHCdM/vxgwZmZH/yuY9+b4oUKyXkgIT08yCK9J05Mc1r545jMc7y343mP4qWCcQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuxEne19iLXvhruhNnGWk9iQ6JGOfWcOT1hCRMG3I/s=;
 b=OWj8xGLHZFG7qWZkTP4CyzO8LUbzy9QjrhbW51idL+bflBwbgYSLXovN+seZx1wJ5rMfz+ipGdFPDFkZC1vwDVLyTHJJtH4wwwR1Ue9Nxzdmex3Shb9vsSdTOid8L2ZLUTb9TIyUmKGB9XRFQz7kKA1UDaxCvkyq4RpvrfN/ezP+R0BZCBDvmtdbFz0CiEMjZEMClEyQf6iTcOC4oh9qnQyKyQ+gZJgmCUNaRZR6cO4RLOOLKgGyWspOSjnchC5CnOEh2zwW2nRA0WeZDhupSFEowhw93+Am/brbubpjrLRoZ14CinbLfoTQJAwcIEcQCbWug2Jvjv+msNq5xNXwHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by CYYPR11MB8385.namprd11.prod.outlook.com (2603:10b6:930:c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Wed, 11 Oct
 2023 06:16:32 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::e372:f873:de53:dfa8]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::e372:f873:de53:dfa8%7]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 06:16:32 +0000
From:   "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To:     "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC:     "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
        Vishal Agrawal <vagrawal@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "jkc@redhat.com" <jkc@redhat.com>,
        "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v3] ice: reset first in crash
 dump kernels
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v3] ice: reset first in crash
 dump kernels
Thread-Index: AQHZ9uU6c+T080bqgkOCqYNNHdK3T7BEJqZA
Date:   Wed, 11 Oct 2023 06:16:32 +0000
Message-ID: <BL0PR11MB312214E63F486ECFDE49E2B2BDCCA@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20231004170214.474792-1-jesse.brandeburg@intel.com>
In-Reply-To: <20231004170214.474792-1-jesse.brandeburg@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|CYYPR11MB8385:EE_
x-ms-office365-filtering-correlation-id: 2116e959-4200-47ba-017a-08dbca219d24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UtOE3dW89eH3Q8mD+gPdBhbRVzQIBY18VcCHYaIcs75NyZ4ogA4KHXTQiw5kR47pArezUnchfv841Aa/UlsM8oc5Kznd3QIMy/AUjUAx6YvNit+Q93fV9mLC5B0NIKpPqqNnuj6ZGL9khtxyJijZIXftKSFYq+U2xKUN7LUXqH+1TONl9BVMn8aDv0hiB00YkoDCj9CeBs5wSAlf6N6PpFd0+do04csTQbRGHC1H3AFU9VUeLg60ND1Y9CbPZ+tyjYFk6dxpSBGjzF3nMc2QHexnEvG4tAjvTdt2Ebk6d5ZPh2CqpawzOLqvGNwWHiDs7P/0jsnnOHyPwLyOsX4Eqh2F7LivDCstpi+OXaQwpSJmgp+un8MoGgQZKy/1P2erXS2AaTT2ih30npObb7Wp+xXhs62T/iMMd6ls9Z4ua37xRbnIBSrfu+jzjRSmvxefYS/xzJX3KxUAgwOOuEK8JWGr6oyNg/DDOQqBYZj5ygNWy5e5GujzfCTvg2gFvo9f92YSSdC1ajJp53wrOZpVuTaYU1kmt6lKPTb8uzu/uMr4yXT2DxCv9cnGggOraAiIWiz3C1bnlW8dvAZebjfyjUzkebq+aP+eBxGd8n/qsJtrecUKq28el7xUoP4TW16x
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(346002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(71200400001)(53546011)(55236004)(26005)(38070700005)(7696005)(107886003)(8676002)(5660300002)(8936002)(66446008)(2906002)(4326008)(478600001)(66476007)(66946007)(64756008)(316002)(52536014)(54906003)(6506007)(110136005)(41300700001)(66556008)(55016003)(122000001)(38100700002)(82960400001)(76116006)(86362001)(33656002)(83380400001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LFTPPh2WCyWhTvbKedPtSl7CogWQJisUByb71a+vGMyFMJwktPxjJVtHPh2k?=
 =?us-ascii?Q?pzehBD1SF3klusJHbejOVfrMSeniMNertU0VccrGLXToMAmV0fgBB4IM76bh?=
 =?us-ascii?Q?osXKnPiSHwTS5HnMSSsi/XrBm6fVnrKgi08LP9xNL63l3UZYNPvIk54oOf6g?=
 =?us-ascii?Q?HuqO/dipVQQXqHR+qNEt1bloqr9Ao+m2uLguJ1xsnK4MFc9S6tufSlOoWaCH?=
 =?us-ascii?Q?2e8EEdGUezggp4ERE+CPQHSa1TRkFffS4SnEajPyTrqc+bOm6XTL7SfNsXTr?=
 =?us-ascii?Q?BXhAKmFCzD5T3q4tA4xLEHKtBQUrPqonofIQu0V556VuzAO3+nd5+Ei8SGsx?=
 =?us-ascii?Q?Jk+FPwhqQVs89dngqaY/aN7TY/LjUDpfcAeqnJz44QEGzF4eSTYNglXKmBTC?=
 =?us-ascii?Q?jwvcX59yBkCcr+4mee4mRQhfIOg2E6EfwhZuzCXskpFhhMSnPRi1zv20T1uW?=
 =?us-ascii?Q?2PRDzaU8ZhaPmY2PbN1R6JlWkIU9KlHGAQZGqmOszlfgcOyzGg0sNg98MTnL?=
 =?us-ascii?Q?R7+/jtpADnQ1pwcBrYV5OU0KibORp4w6IdNN1u098g344WZSc69zmN0bRTja?=
 =?us-ascii?Q?jwmpelWyZNxoBAmtEZBjzOzOFL0LyFYHe0oHyzzXj9dm+O/KoatD58xc4kpd?=
 =?us-ascii?Q?NJdnPwsK/RG+2wQFjumMK56kw23UOkUmRL4yyIM0CNJFSf1oDG4bFSc+HavW?=
 =?us-ascii?Q?EtcNMIlSGeWBnUrdNIuLiiZAFhET62WqRd7OOjwpsqIseX6tHvwwbHJlc/WC?=
 =?us-ascii?Q?n8pEw9JOajZ5mK6sP8Rn6ZZODMgan1zgQL9k0ZkotKK+GZpKbX73rnEwSMt8?=
 =?us-ascii?Q?ZtsEB8dzF+EBU5gtDgzlJ1Ui2s0OkBssSEDnEhUVrcs/Le5eaHvKa5bSXLDP?=
 =?us-ascii?Q?oLu3wvm1A5QaI4d79+86+Kx5XpQ2322w+vgYjkqaYmlpXeuMc1kh24HLeMvo?=
 =?us-ascii?Q?wWJOOOQazY9XwN4bC2SzDPO/9JH4Cbsn5O34oX1ZRj2U1dCGb5X95XFPLd0G?=
 =?us-ascii?Q?ECyryeD4NCBQs2TjXvhp2YsE2wYJk+eo18qWcjYrsQJAZXAoalMfk64uxO8z?=
 =?us-ascii?Q?s82pbu3LBz2bY1grdA/qgqU16Exp1fyqGqowSUPOcQHGs0VjrbsuADMoroze?=
 =?us-ascii?Q?MM7j1YzVAqkcxs3KQVlYmnfO410G8iLsnLoodQW+S7X+8Y5/11qIG5l7gXPV?=
 =?us-ascii?Q?V6wXcc5NYAUJlR3DKUajFX0GKmlz5yz4kbbWJLUXc8md55UhKVj10L76oUjd?=
 =?us-ascii?Q?Xs/FGNkb/bGRsKwdE8kGYzEcysylciHZkvjVuuxdWd0yN4lqpPrNlGGxwFF7?=
 =?us-ascii?Q?kpPy+2+UN276igW2W3gpGmUS1NlXZe9ehmu/LUARzq0kY7ynDesDzcQPS/i2?=
 =?us-ascii?Q?RQMdq/VBqj+X0hLJ6MomwBGshiWiSZghF137CPD89LTtHv8Dc9wQnqR39kIv?=
 =?us-ascii?Q?BjrLFFSkLMN1SpaeUy6xTFq1JZgPdgMg+vs5wRXuwlm4sDmqmBJFMGgJgnXj?=
 =?us-ascii?Q?zLS9wacImZahz+h494VQf1qgkqrIchzC18t42xjma09C6MDEZcC1CI/0wzTT?=
 =?us-ascii?Q?lr16bKcUWB2buOUM4deqYbSq1In1njCqq7P9HJDZNZ1osxPSyxz+o2AHL/ct?=
 =?us-ascii?Q?eQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3122.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2116e959-4200-47ba-017a-08dbca219d24
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 06:16:32.1614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RIGGkorEIKt9azb33+poHvmLmtBoyU3Jmd8GlRl96D1RCy9AXDUYKqjsLfnWydO/hJlqHyRXj3BFCmxQhSxbkh3Kxz3wsWlXZ4Sg0NY8g/UUSGokyWSCPA6t9bseEcxS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8385
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
esse Brandeburg
> Sent: Wednesday, October 4, 2023 10:32 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: pmenzel@molgen.mpg.de; Vishal Agrawal <vagrawal@redhat.com>; linux-pc=
i@vger.kernel.org; Brandeburg, Jesse <jesse.brandeburg@intel.com>; netdev@v=
ger.kernel.org; jkc@redhat.com; Kitszel, Przemyslaw <przemyslaw.kitszel@int=
el.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net v3] ice: reset first in crash d=
ump kernels
>
> When the system boots into the crash dump kernel after a panic, the ice
> networking device may still have pending transactions that can cause erro=
rs
> or machine checks when the device is re-enabled. This can prevent the cra=
sh
> dump kernel from loading the driver or collecting the crash data.
>
> To avoid this issue, perform a function level reset (FLR) on the ice devi=
ce
> via PCIe config space before enabling it on the crash kernel. This will
> clear any outstanding transactions and stop all queues and interrupts.
> Restore the config space after the FLR, otherwise it was found in testing
> that the driver wouldn't load successfully.
>
> The following sequence causes the original issue:
> - Load the ice driver with modprobe ice
> - Enable SR-IOV with 2 VFs: echo 2 > /sys/class/net/eth0/device/sriov_num=
_vfs
> - Trigger a crash with echo c > /proc/sysrq-trigger
> - Load the ice driver again (or let it load automatically) with modprobe =
ice
> - The system crashes again during pcim_enable_device()
>
> Fixes: 837f08fdecbe ("ice: Add basic driver framework for Intel(R) E800 S=
eries")
>
> Reported-by: Vishal Agrawal <vagrawal@redhat.com>
> Reviewed-by: Jay Vosburgh <jay.vosburgh@canonical.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> v3: add Fixes tag as approximate, added Jay's RB tag
> v2: respond to list comments and update commit message
> v1: initial version
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)

