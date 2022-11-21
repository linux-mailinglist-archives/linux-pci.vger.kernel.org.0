Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7964F63186E
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 03:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiKUCBk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Nov 2022 21:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiKUCBj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Nov 2022 21:01:39 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2BD18B0D;
        Sun, 20 Nov 2022 18:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668996098; x=1700532098;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ryh5pggpDXpy8Dh1mkByrZpIQvvE0rAUq0vF6f0+6e8=;
  b=SF5ydED3m1IEay80+cvTwiCIUVnqXWPlRvorjuKt2P2OyTzHMoRTOAxB
   dVd82QzpSvPNdH8O1ilKP3ouihxkZAvRnsPPcyyxTleWitIO3dw3h4il9
   ZNu4DLcwTavM6PtXRQ+xNPeCFmwg5ufLkdr7k8yU9Ee6MQSARkxD9ADF5
   l+RiQ8OoEJKAQ8/EjbK0O2TckT/tqCjU9kqEBrfCW0dGgYS+K3RnsIbBZ
   1P34my9B+09psfuACT4mSHCqpP0bc3RXzbBSvCXbC1fdsUPgTssjiNpSV
   jL1Cty07RXotrfUY6xdtBE7/T69NEywwEJc0Ny6VAQ9EO02dsb26iQj0w
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="293843371"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="293843371"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 18:01:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="671931992"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="671931992"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 20 Nov 2022 18:01:37 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 20 Nov 2022 18:01:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 20 Nov 2022 18:01:37 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 20 Nov 2022 18:01:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CF4ReQ/B8ExtCmO5D7lYQyIH9aBdwerfiUSthu08t1Rl5Gifk3ZuayQill7P3VjmFsOccz54jJaxBxrwbfkqbs2/LFLSsdJV2JEaOShRfElKEz1zQKkOpgqLeEdAJUZzchJfPgAq8sUtbDQW7wGDMy3zKpD/eLO4RIxArNO+HSlXcWMh0UdBSCmvxIkcqhroO6tYNpgMaY3rmMBRuWyiJK+totCa95p/eXFC9/KYnTUbt/A+Ib4JF4QmGL76GyZz2hnZWz3qjc2OAuvY8OH+DqE3lhmyDX+GIsNDNmMDSg+1My8MCEE16FWBTWNG27VRwkmuGkha3sHXn4CW8f6teg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gr6VhPYZq4e74ObyIgcRRdGFkGeJDjKP+qczPMnI07Y=;
 b=iRQ5O5WnBZINzV90yfIHYKwf4VSA5WZbxArxWxSSoVG7cNESxyijQVTz0by7PdnX3e0HtBuNj1PlGEf0uH/yA7Uf3Y4dhorhCx6wVm7wEvFuvUDQW1E045uZrrtrRkG4ucCqChNAeo30ilHgBKGJk6cGjcoW0tuvDvP8qSMWtuNkPk9kfz9SAerWvrSz3SoPcyrMtfatBZKFGkaX0jGm73B2RmAISyHyHc1J2u1GfkkpvDS3uWqd4No8aRLFBKGz14JOZ08R+D6/eOQ2jWZqCiBHm59So0Kia0DNsL6Chu35hMPpCw9BN0orNHLQDK8CCfFr48/aHi8JBwpynhMknw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 02:01:33 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::d204:9aee:594c:273e]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::d204:9aee:594c:273e%5]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 02:01:33 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     "Weiny, Ira" <ira.weiny@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "Weiny, Ira" <ira.weiny@intel.com>,
        Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Li, Ming4" <ming4.li@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] PCI/DOE: Remove asynchronous task support
Thread-Topic: [PATCH] PCI/DOE: Remove asynchronous task support
Thread-Index: AQHY/GXd/0D4hRhIPkuRQ8htDgun0a5InQpw
Date:   Mon, 21 Nov 2022 02:01:32 +0000
Message-ID: <IA1PR11MB6171B27750AB469AFE47CD5E890A9@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <20221119222527.1799836-1-ira.weiny@intel.com>
In-Reply-To: <20221119222527.1799836-1-ira.weiny@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|BL1PR11MB5978:EE_
x-ms-office365-filtering-correlation-id: 08f3a3ea-63bd-4e97-6329-08dacb64503b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 18g5AD5fozd343auuOLeYxNbEmP2oEq+igVFRyihXhNjn0j5dVUFTGMW5+eIOEJc1XSzPvbW1q7/U6NeHeSksX4u7+hT0kSGx98T6F5pfWJaSMOWxldZriSs0rJ6NgkY8IKodtlbJ2LTEd8RMpeG/Jq/jvq91KyMM7vERVAgeewnxgujsQpi5n3v6yhI1Vai77ENVNNsRJlZ+zQ3uG+/FqhCp1BJ7HNRJdnk5YRax8a9XH6flnlAxNyc7cevXM6rb1gVc1CUC9xIhxN22eqAufwz+hH4UKbY1t54+5aQ11filgf9FuoxkJFSmFKNtJfK1i15VH00EW+KctknwdeAp+XHxYkzjCpzNHY1k15WHgRuEDdbkYZ2urbz3w5PF5KPbD7LT0fWXWqdhhkj1zgpcure+aVSs0HEmWqbpPbgU2pJeEbuLhdztGgsd75VF0ol/+FQDKacpRbxtUX5kLOlz0rAJQ6IhF8IkZXYtStJfUZvDoSlhF+4s0GZdi5US/oNXLxKvRBLn0c7AlloZDS4EHMAkq76vaDI4SQOyhhaWB1bJ5QZ3twJ/gi4c+1MpIhDckE+fuy759cKkF7/FU5XbgDIQwPgni4ylMJkLTz32L7f/6tGE7cKh+qmqd1NwkR108+SR2BWE4dOW2LldNVyxrDjCCNBZ/3ClPOLMWPw8B+pHIC3XA+jcufNJBim8woek9QyQSK0lE8ZYrggIHoElA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199015)(2906002)(86362001)(478600001)(71200400001)(316002)(110136005)(7696005)(41300700001)(52536014)(6506007)(5660300002)(4744005)(33656002)(55016003)(38100700002)(83380400001)(82960400001)(38070700005)(4326008)(9686003)(8676002)(66446008)(76116006)(64756008)(54906003)(66476007)(66556008)(66946007)(8936002)(186003)(26005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?WU5sbjhhaFA1M1cxNkhXaWRFNHZ2SGVLeVpMMkRoVkRxOVNEZ1FLMmo4?=
 =?iso-2022-jp?B?WDhDSmZmQUs3OWdWWCtIbk9pY1dpSDlvQ3dRejU2MFJ4YmwrV0NFNC9C?=
 =?iso-2022-jp?B?TmtmQlBVd2Q5WmM2T3lRanlPNmM5RHhKQzlaZENPSEdiZDVzT1JsdmNr?=
 =?iso-2022-jp?B?V2hqNmExMms4eTZaaUlNaTBXeXdBZkp1L3gxYmlmSGxZOU9ZVDVhQ2dW?=
 =?iso-2022-jp?B?UkdjVkpCcGFyWVdoWnlaRFBpQ0Q2aXgyOHR3Z3RMTTJOQzB1MEhBRGR1?=
 =?iso-2022-jp?B?QnBpZTNyT1dxL29uYUY0Mk5MTmxYR1g4Mll6TGlJRmgyS1FyWXE1b2w5?=
 =?iso-2022-jp?B?MVVvNmh0S2l5cXdQOExJVmdIMFdjOE9aOTJ4ZGpPNlFxK0RQbmpsMzV6?=
 =?iso-2022-jp?B?MXBaam5EVHZ6d3pzY1BQbENqMzdIUGNDUnJsV0JYVFlqcGVWWjQ4cVdo?=
 =?iso-2022-jp?B?cWhqeUM0SGZYSnRNeEl0OUZnbDlhcTYySEhzdUVOYmVjUE05MEJEOWRW?=
 =?iso-2022-jp?B?L3NBdGw1Ykt1blVGY2F6SGpOdnN5S3JnYmFNU29uK05GSkJmSkgvdWha?=
 =?iso-2022-jp?B?eUM4QTFXSk8zL01iRWdzLzhHQkZIQWNGN2RYU3l5T2VoblBsQ1p5Qjla?=
 =?iso-2022-jp?B?UHBCVlJDWGRZbGdUTFNGSTNJNHlLTFp4MjUxQVlqdm9LcG1JNWdBUGFo?=
 =?iso-2022-jp?B?ZjVmT3ExZVRLOGNQZXZLenVSK3luNWhNTHpHWTZBaUUrODdZYUM2WGlT?=
 =?iso-2022-jp?B?b2FlTStmMWpkeWdYTEpHd1U1TEk4WlZrUkRwVXhaYkxqMTNkZm1yV0NL?=
 =?iso-2022-jp?B?Q3Q3OW5DbkhCR2JielZ2UTR4N2NNeEVuaCtUS2E3K0E5bWRnU3JHS05y?=
 =?iso-2022-jp?B?Nko0cDBIVTErRkxENHk5ZWhBL0hkcnJsZFIzZkI4SXFaUUZ5cVVrM3hh?=
 =?iso-2022-jp?B?MXNaZkxLc3hNTEUrUDZLNEZFVEZKV3RHbDd4d0hEbVZlOW1udXg5MFRS?=
 =?iso-2022-jp?B?TUlQV0ZVdzFRUWhnUExwNGxNMDhKVTdJSHNVWWo3eGJISGpucDNRWGds?=
 =?iso-2022-jp?B?TnZScTlVYWlxUWJUaGg1OG5PSThNU3BkNVlwdlU3cUVLTlBTd1plR1Z5?=
 =?iso-2022-jp?B?MXN6SWwxc0o5eXZ2TFpZNDYzbm9qUENTMTdHZHJPSHhVWi9INmFHQkxz?=
 =?iso-2022-jp?B?VGFwZFJTNUdtb0FXdHVTd3ZGbnhweFc0bkhRNE56ZWZybC96V2k3R2RB?=
 =?iso-2022-jp?B?N3FLVGVCRlhEKzJHSWFHY01QQVR0ak9oYzdFc0Z4WGVRMnVHWFJnR0d6?=
 =?iso-2022-jp?B?Y3RPSGNveURmc2RGN2g3NkJUKzVuajhNWEo4UUUxSnRhbHVsellveFNt?=
 =?iso-2022-jp?B?YmNUdkZxK1FHdFZoUzZRWjJ5N0ZvRnNyVGc4Sk9pWjFhRkpISFR6WFV5?=
 =?iso-2022-jp?B?NWRaSHVLMHUzdnI3cjM0VzVpWGhzNjNkc2NaWEV0WEJzeFVhUjZGVkxa?=
 =?iso-2022-jp?B?V1VKM2o3cUVrL2plMUVUaVBmNFRacHlBZG5zdmF1RGxNdE1wc01SMXJw?=
 =?iso-2022-jp?B?d2xmT0xUbkdsU2xQNVdvUWhzajhZenFPazVvSVRUdlB5amtzeUVtZmdK?=
 =?iso-2022-jp?B?c0ZUcThMMEZ1VTgzbWVOQXpybWZJWjZnRVc0ZlQrWW9GdW5HM2ZFekxG?=
 =?iso-2022-jp?B?NS9sMmxaVGVOQTdteVBZWUZqV1Z1U0E1SXBDZU5QTmhVMWpIcERwTkN3?=
 =?iso-2022-jp?B?bUhlSkJEb0g5TXk5aDdvdUlCN2YyekFRUitWcUk4QWloMjUwb21Yald2?=
 =?iso-2022-jp?B?RitKanQ2ejdEK3J2cUdxRy9CZXJmMU5vTE9CNWE1VjdROEdIQWNsRGFS?=
 =?iso-2022-jp?B?R1RuV1B2UE8vUGk0NUZMK3ErSVptMXFwYjdoMnkyKzBoYW85bThpTTQ3?=
 =?iso-2022-jp?B?MzQ3TEFjUHNhdXZPeXJjR3BmK3l6NXIxVmVWOVJhaW5Ha1B3djZzT1FI?=
 =?iso-2022-jp?B?YXIvR2kxSUQ4dGhXVU13YUlvejFXbExjbERIZnVmS3NKcWpDNlhUa0FK?=
 =?iso-2022-jp?B?ZHhHN2dqd0xSc0hSQ3Q0ZjVGdGw1ZTNPRmRWZE82WE52dnJBZ2lDd3Nx?=
 =?iso-2022-jp?B?d0paYkQ5RnlHd1hSWWxxSzlzMVFMU3dOKzZuelVXeEhpVGJaQzNDRFZz?=
 =?iso-2022-jp?B?VEZzUE1CUHg0NlhVaEZPSTMvQXh3V29MVFdmaWI1ZzVDQmFVNENSNC9z?=
 =?iso-2022-jp?B?M25lZDcvM3NWTTBaYmxOaW1RcWZ0RDZqbDAxQmlyZnJiMEpSQjFldUwy?=
 =?iso-2022-jp?B?bWcraw==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f3a3ea-63bd-4e97-6329-08dacb64503b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 02:01:32.9115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YzIIe/kBMDd0DpCg99TytrdGilC4VRrpCDH2OCdajbF3zQB9XPwmbGJ9boJ1Kl2ec8khr6S9CdQ8OFVz+NZ4BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5978
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Ira Weiny <ira.weiny@intel.com>
=1B$B!d!!=1B(B...
>=20
> @@ -423,25 +399,13 @@ struct pci_doe_mb
> *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
>  	doe_mb->pdev =3D pdev;
>  	doe_mb->cap_offset =3D cap_offset;
>  	init_waitqueue_head(&doe_mb->wq);
> +	mutex_init(&doe_mb->exec_lock);

In real world, not sure whether there is a case that pcim_doe_create_mb() i=
s invoked by=20
multiple drivers to create multiple DOE mailbox instances? If there is such=
 a case, we may=20
need to ensure there is only one DOE mailbox instance for a physical DOE of=
 pdev @cap_offset.

-Qiuxu
