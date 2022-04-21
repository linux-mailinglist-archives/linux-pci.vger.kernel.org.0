Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7C350A145
	for <lists+linux-pci@lfdr.de>; Thu, 21 Apr 2022 15:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388186AbiDUN6B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Apr 2022 09:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388136AbiDUN6A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Apr 2022 09:58:00 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34A92BB1B
        for <linux-pci@vger.kernel.org>; Thu, 21 Apr 2022 06:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650549307; x=1682085307;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vvepP736RRnisQGq0S22XtAzHMxGHbm2e5crxjSrJeo=;
  b=a9wg4Qx6YK0i0kjnahTJuIvKE1wNY3QpMKLpF6NdDI0OmgoZvIQvlIAg
   hbbpi7OGUmwMuUfABqnbe7OvGBOx1okW5uIwGTjG+xsOxneJDB6PY4snH
   022ITccuGVWiRxgCKjJJSz71kfXTnJL6Q8rLMqbgUp45JI+piJrTfSExE
   DH6s1GxH91W2W4MQ+sJe3tk+QcVoqd912PmVtJrWkXc5TRL5dEJ3WYPbT
   F9Syaehiu2z7LQ7tztGubAIONKbJnCMk+S/ITyv1Q/jZaQTRuFUgW8wEt
   EUD5RcMuZfx7vtA0u+MPS6f1vUd2xvAZnaH3At/2WAZokY2Soxpu5QohQ
   g==;
X-IronPort-AV: E=Sophos;i="5.90,278,1643698800"; 
   d="scan'208";a="156311712"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Apr 2022 06:55:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 21 Apr 2022 06:55:06 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 21 Apr 2022 06:55:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i557AGaNnEfZkQK6q07rpKeXsrTyXj/TgFG5rh7wTZALE460CBAS3rSFWXkW13u1SG1Ge2yZZLZ5wD2g/D64PAdJM3uucVsHciyfRLEQu7T2c8tFxz01h8M5fTLCHD6uTLOzMmpZq7cFTCRLkRs8Dh7+JblrD2Hvw2BpKzHAq01duQaXkWsku+gUsa7WMukvYrLzxJQdU9aa3FEKnXuu+VvU7rQrvNugBywk7C3GclF4RHDYRW0CgLQ23PfdBD1I4fZimanDUmTqp1g6dKnjvVhhvJfKU7iYcVx4ZZUFPRRU64c0HGP5d7sOhFip6GjIp44Wgax+39PU9zFdhvaMGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvepP736RRnisQGq0S22XtAzHMxGHbm2e5crxjSrJeo=;
 b=gFIGL1WUC0AJjX3+O5Fz2wdwzkcGWb8s3kNrmX8K46gfko/aOjSr7TpPxF1vVbg1xA8sLlO7LsfOvFSp3SgnR0NaxeFGHoqzsciLMO5nNW+D7W3hhIaP53/1WsDX7T7ywX/VBSt0A0AFjtXGae2L6wA945am1FfC8XGDL3JJwgYJQlnKNCNoZuqxh6Q7NKZLHM3kNgKB0YABSpI6AqtKQIyecl71Jt9qc/DnsXwht4GIW7wIvraUKlicHFI0NBKv5w8TjqeDamEY/qBB+DMWXsJBoUl/FWWBr8usiQJhJg5DFTplWC6UeEEq49IzEnrKqIz22AUDYoA8Eb/VdugajQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvepP736RRnisQGq0S22XtAzHMxGHbm2e5crxjSrJeo=;
 b=T2hERcQ6FjPnjaAKzoxfri+h5DiGwLkyZgHmFw9dITNJ6VKpGdxtXrBuBkS/cvIgg3+2KssdvxCPAAQzCnD5Rx1oZD0abZba+yiO/b/UkZJtVXqKGRc1oOQgY7vdyfZOC3ZAuWIggiAiyvBSGGM9+to4Fed5fAHAiZ7Z8O6S4xE=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by BN0PR11MB5694.namprd11.prod.outlook.com (2603:10b6:408:167::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 13:55:01 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::fcd4:8f8a:f0e9:8b18]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::fcd4:8f8a:f0e9:8b18%7]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 13:55:01 +0000
From:   <Conor.Dooley@microchip.com>
To:     <pali@kernel.org>
CC:     <u.kleine-koenig@pengutronix.de>, <Daire.McNamara@microchip.com>,
        <lorenzo.pieralisi@arm.com>, <robh@kernel.org>, <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <ian@linux.cowan.aero>,
        <kernel@pengutronix.de>, <gregkh@linuxfoundation.org>,
        <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: microchip: Allow driver to be built as a module
Thread-Topic: [PATCH] PCI: microchip: Allow driver to be built as a module
Thread-Index: AQHYVJn7sorTKwljF0ixBpG4IvND9Kz5Ac+AgAE7hoCAACRvgIAAA7qA
Date:   Thu, 21 Apr 2022 13:55:01 +0000
Message-ID: <787e21f9-9db6-8c20-4983-17ff59b4e045@microchip.com>
References: <20220420093449.38054-1-u.kleine-koenig@pengutronix.de>
 <20220420164139.k37fc3xixn4j7kug@pali>
 <bad31f90-f853-fdff-c91c-1a695ff162d1@microchip.com>
 <20220421134121.pnhlwm74yzd5bdrs@pali>
In-Reply-To: <20220421134121.pnhlwm74yzd5bdrs@pali>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 929567cd-33e1-47b3-4620-08da239e8779
x-ms-traffictypediagnostic: BN0PR11MB5694:EE_
x-microsoft-antispam-prvs: <BN0PR11MB5694B6FFF13AD4F5A9E6545E98F49@BN0PR11MB5694.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F27qEo3ATmEP8NEIZUGWJM5Z/mTj4rHMZIHgNijkYdEZcy3Pv2lMKpnaWZEapIAcg/P6TMyr5xbtTmWwJhOdMzL42MwkbPfZeJjR91LCXF2CV7YT+2vDn/02Vycioeq4UOuZfO4yKFh5yDRZy1C7hoALI5RIqF+eMT6WTLh9oJGfTsLouQNQ4IwaoxL5rDEeCDIyVtKvDiLMHACFz923s9U0LKdgIxfVJ6ku73dE0Edx8/xJV7xBdPY5mSHxNT0da8ou/AeilzmKxOlCJRPkr0pp8NTZLfygSgx1ITzHzW1bobWaqeVNUgQUy0WsHLJxIw9SljudDHZY6MHtMRsSEUD8Dsxg+Py35hpFZ5l8Rs0s+JkLKnznPdI3QAjqEqGSeHDEL31fe2Sy+mOySINBpjm2AdGn8TURsbU/91gdGTRaov1rVeAMciyhlO7PS4hmM2wwEoA4AL9UGeMIjmofj314Oz0BH9X4iLWnO3Mn4mZlWWYjJ2FgdAABqBiAIoqamB+yfOiyVrO2sUDMic6BMfov+tIWKwoyUUdm0xXfp2z9HuGM3tkyPSU2WUtjbGZ+QXmOXKREtQuSZVyKcz54UVnTONvk0YX7XWIIi9ocUlxR6ouZrE0MGONNcto4tJo21exLjQ3zw2p06Pfvnys3Q3jzAVdpwImyfSlWrBQO7JrsV4Q/D8IJoJUeMqtS7CFBAIIJ8LCkGF34tQvDCemVgkjQEVyepQS6GkE+ggvCOZ4gDYcx49Zl0WZAK5Azdd0EBBpvMM0GbTBq+NbpzpqgGH1gJl+7PtQKhTt0laQoEKU/kIOY6/PfOAKa/+0aEfmyOy4U7drceZ317UY7InTqNOJwx4YQxs3zpLVHbXk8oW8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(31686004)(186003)(71200400001)(31696002)(86362001)(83380400001)(4326008)(64756008)(66446008)(66476007)(66556008)(36756003)(66946007)(76116006)(8676002)(8936002)(54906003)(6916009)(316002)(5660300002)(6486002)(966005)(7416002)(2906002)(26005)(6512007)(2616005)(508600001)(122000001)(38070700005)(38100700002)(53546011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZE9tRjgvMGQ5bW5adFA2ZzFwVHBnUlJpTkJWNVU5Tm4zTXdoMitxenlBT0dD?=
 =?utf-8?B?SzBEcUM0anNMdUsrMmNyYjZnZnhZS0ZCU2g3ZVFUUzZlSUkwU094dzczcmJt?=
 =?utf-8?B?TWY4VkdCNEVBbktCZWpodTlhcm1ueUdxMVk0Tmt4eXBITkhONkxCNjg3aFhq?=
 =?utf-8?B?dU5RU2cxaW1NRFZSaWNqWVpGWHJBOWZhcDVzVjg0NTMxZklKY3ZOd3FzM240?=
 =?utf-8?B?TUluTWhNNncybzFLY2F1b3JyZXFnWUZGMEcycFhLQVdNUjBrQm9jK2lOeENZ?=
 =?utf-8?B?QmFUTGlhWmRYZ1EyaVlBZk5POE5nVXk5M2hGYzM5bjdwMjBGMGJuaXZCMG9W?=
 =?utf-8?B?bVAvQ2tLUy9QeEpJejl2WHlKZWxQSkZVei9KMncxNkVZMGlxVFVqNDF4cWda?=
 =?utf-8?B?UkI3QWhqMTYwOURIUGFBY2gwaEY2clVFeHBCSjhXSU1TbDRSTXdpWFBMTU5y?=
 =?utf-8?B?WFV1MjhkRVNQN3hBWGVaVTFteGdqUCtoT0hjUFZEMmVpc0lCUWZPVS92U2VB?=
 =?utf-8?B?OTAwOHhmZHlGbTdXZ0hxMWZBVVFxUVR3S1kzaHpFM2tKYkRtN3ZTRkpJaWtp?=
 =?utf-8?B?UjRzTC9BNVRzVHFqVk96enRRd3hWYWs4MldhdmhxZitKMjRuWnkyM1p0aUNX?=
 =?utf-8?B?akRnMkxwRzIzd2N2cE5lL3FOSFVGYy9hWW5zMlJCQUd3VVA2aVgrQkV0WEZm?=
 =?utf-8?B?WjVqTVFWNG9uSHJPMzlkMUh5SnROTkVlWm96WUVXbEwxZFRWd0lzM1hDRVJK?=
 =?utf-8?B?SitHN0JNOVVMM1VZVUpYQVI4THMybmdOQUI5cEN1dVQvbnkzek5BZlZGb2FF?=
 =?utf-8?B?Q25Ia3JGTHExR0FZMEJXQXdySGZuck1ZdERtb1g2R29iQUxGKzV5d0NpMEdR?=
 =?utf-8?B?R0ltS1FRZzN1cTJ3TWFNSmxIaTNlK3pqaVAyaTA0Yzg4akZDZWpOQm5LcmQ1?=
 =?utf-8?B?T0JSYkl0cTRHSGkwWklKckhhTXpnWVdoQ3BCV1RyZE5VVmJwSmM0Qm14Uys2?=
 =?utf-8?B?OXY0UlB6Qlprc3BPUkUzY3FGUitrQmRId2MxRy96QWNkRXpZc2pvKzlWeC8r?=
 =?utf-8?B?WCs2NWttNVJwN1ltZzZpL1ZsZFJadGNVR1FNK1BNSkxsbE4zNmtoaVFqQTJa?=
 =?utf-8?B?cU01anMySHNEZHpPQTUxTXRtVmNtYXlrUXNqNWVlZ1JJU3luR3lsQlRzV1B0?=
 =?utf-8?B?bWF3emlUTm5HcThlS2t0N1d6MmozN3hFNlZSeWt6b2lMV0NIWG1JTnBSRnp6?=
 =?utf-8?B?eWpBVkhrTjBJQ3VoTlhZZEdDSlR1U0FHODhjQitkTTZLNGFGSVNiR0g2NjQ3?=
 =?utf-8?B?d3RlUUZjUk5KK3g1dUNFazJUN0RRTmRrSTZlT05FeW02WFFGRERaV3hVZ09V?=
 =?utf-8?B?MmNqRUs0Y2VjaDZsS1hpYVg3ZG9VRUZySDB4N1IvZWliWkFWbnpTSFlDcGtZ?=
 =?utf-8?B?cWxKY21BTmVBeGQ1U3R6OGZMaGdqSk1tS3g1WHJaa0x5UEFCaTMzZ2ZZU20w?=
 =?utf-8?B?K0NPZk1EZ3BOTnUwVTRmTFFNUzJGS215aTFaZS9iSFkxU3ZrWXBoVWRpNlNq?=
 =?utf-8?B?OFpOb0o4akl3eS85dndRelBCMUNUSW1Hc08xUHh6NmxpemYzS1kwNE5uMUNF?=
 =?utf-8?B?WFRRYTd1WExienlUSXI0c3hhbE51QktBWmY5UHZMa0pBUnlvZFphZUtMOElz?=
 =?utf-8?B?TWU3cWI4UlFjNkxRc1FDem4vZm15c0VNQUFORUNZYTFEYTN4eitPYnVlM0w2?=
 =?utf-8?B?d2JCK2taUVdacVhOa2piRWI0bVFwczRBbnR0UUVVNEdCUWFzZ2l6bDZITC9X?=
 =?utf-8?B?WWdDZUxWR244SHVYNHozeXN3ZHpkSmhpV2lSVHF4c01Mc2R5ZS9Rd3pJQ05z?=
 =?utf-8?B?Y1oyMjFNakFoaUppWFF2ekt5UGlKZ0hVMUh4RTZqVTB3LzNoUlBuTjRUSmNV?=
 =?utf-8?B?WmRvM1dka3A2dytpUXFJOHU5bU42dEFHeGdvZjROb0szeUFOOG9kaWN4T2I5?=
 =?utf-8?B?ckdNMTFDQmJpSzlSMWRTZG5Ldm1BTFZqdy9CUWFsbDVpbmZoaGRUYWJsMEdi?=
 =?utf-8?B?aElxUndpTno0U2Q4Q2pLRVhBU1JwMXVlZ0NWNUFKYitDOE54QWZRcjJiSkdM?=
 =?utf-8?B?QzlKSUhObytjRkVuSEdieHM0MlNLc05hSXRWK0hyQzhqMUpHMG1VUTRFcTlo?=
 =?utf-8?B?ZmtmT0xNZXpaUWhFVjhzZmdyQzlpMEhIbDY5S3ZmMy92Q3JsWlB4Vmg2eDVR?=
 =?utf-8?B?MEl1MDRCMWFPWnduYzlCVTVjOGN0NmREZ1pnbkxmN1VCVXlRb1l6K3dxT1c3?=
 =?utf-8?B?WmxvUkgrQXovcVl0dkJmUTZuRE5BbnBrQlkyeTJlWk8zQjRXbkdoQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21FCC2C2C54B33418F29B7CB71411ADD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 929567cd-33e1-47b3-4620-08da239e8779
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 13:55:01.0710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FLANzIpo3CXo2FXUZGIZMsw3Beej2RJ2ZduVUMruogt3uNT+vyUtZFvpDfcO/1tiCqSpfChpBWjOsMEPgxXee3iHNprvhLOdVfS58OXR0SI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5694
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMjEvMDQvMjAyMiAxMzo0MSwgUGFsaSBSb2jDoXIgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gVGh1cnNkYXkgMjEgQXByaWwgMjAyMiAxMToz
MToxNiBDb25vci5Eb29sZXlAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IE9uIDIwLzA0LzIwMjIg
MTY6NDEsIFBhbGkgUm9ow6FyIHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xp
Y2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQg
aXMgc2FmZQ0KPj4+DQo+Pj4gT24gV2VkbmVzZGF5IDIwIEFwcmlsIDIwMjIgMTE6MzQ6NDkgVXdl
IEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQo+Pj4+IFRoZXJlIGFyZSBubyBrbm93biByZWFzb25zIHRv
IG5vdCB1c2UgdGhpcyBkcml2ZXIgYXMgYSBtb2R1bGUsDQo+Pj4NCj4+PiBIZWxsbyEgSSB0aGlu
ayB0aGF0IHRoZXJlIGFyZSByZWFzb25zLiBwY2llLW1pY3JvY2hpcC1ob3N0LmMgZHJpdmVyIHVz
ZXMNCj4+PiBidWlsdGluX3BsYXRmb3JtX2RyaXZlcigpIGFuZCBub3QgbW9kdWxlX3BsYXRmb3Jt
X2RyaXZlcigpOyBpdCBkb2VzIG5vdA0KPj4+IGltcGxlbWVudCAucmVtb3ZlIGRyaXZlciBjYWxs
YmFjayBhbmQgYWxzbyBoYXMgc2V0IHN1cHByZXNzX2JpbmRfYXR0cnMNCj4+PiB0byB0cnVlLiBJ
IHRoaW5rIHRoYXQgYWxsIHRoZXNlIHBhcnRzIHNob3VsZCBiZSBwcm9wZXJseSBpbXBsZW1lbnRl
ZA0KPj4+IG90aGVyd2lzZSBpdCBkb2VzIG5vdCBoYXZlIHNhbmUgcmVhc29ucyB0byB1c2UgZHJp
dmVyIGFzIGxvYWRhYmxlIGFuZA0KPj4+IHVubG9hZGFibGUgbW9kdWxlLg0KPj4+DQo+Pj4gQnR3
LCBJIGltcGxlbWVudGVkIHByb3BlciBtb2R1bGUgc3VwcG9ydCBmb3IgcGNpLW12ZWJ1LmMgZHJp
dmVyDQo+Pj4gcmVjZW50bHksIHNvIHlvdSBjYW4gdGFrZSBhbiBpbnNwaXJhdGlvbi4gU2VlOg0K
Pj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXBjaS8yMDIxMTEyNjE0NDMwNy43NTY4
LTEtcGFsaUBrZXJuZWwub3JnL3QvI3UNCj4+DQo+PiBIbW0sIHNvIHdoYXQgaXMgdGhlIHdheSBm
b3J3YXJkIGhlcmUsIGFyZSB5b3UgaGFwcHkgdG8gZG8gaXQgeW91cnNlbGYNCj4+IG9yIGRvIHlv
dSBub3QgaGF2ZSB0aGUgaGFyZHdhcmUvd291bGQgcmF0aGVyIHRoYXQgd2UgZGlkIGl0Pw0KPiAN
Cj4gSGVsbG8hIEl0IHdvdWxkIGJlIG5lZWRlZCB0byBpbXBsZW1lbnQgcmVtb3ZlIGNhbGxiYWNr
LiBCdXQgSSBkbyBub3QNCj4gaGF2ZSBoYXJkd2FyZSBmb3IgZG9pbmcgYW5kIHRlc3RpbmcgaXQs
IHNvIEkgZG8gbm90IGZlZWwgdGhhdCBJIGNhbiBkbw0KPiBpdC4gSSB0aGluayB0aGF0IHNvbWVi
b2R5IHdpdGggaGFyZHdhcmUgYW5kIGRvY3VtZW50YXRpb24gc2hvdWxkIGxvb2sgYXQNCj4gaXQg
YW5kIGRlY2lkZSB3aGF0IGlzIHJlcXVpcmVkIHRvIGRvIGluIHJlbW92ZS9jbGVhbnVwIHByb2Nl
ZHVyZS4NCj4gDQo+IEFsc28gaXQgd291bGQgYmUgbmVlZGVkIHRvIGludmVzdGlnYXRlIGlmIHNv
bWV0aGluZyBtb3JlIGlzIG5lZWRlZCB0bw0KPiBjaGFuZ2UgYnVpbHRpbl9wbGF0Zm9ybV9kcml2
ZXIoKSB0byBtb2R1bGVfcGxhdGZvcm1fZHJpdmVyKCkuIElmIHRoZXJlDQo+IGFyZSBub3Qgc29t
ZSBvdGhlciBzdGVwcyB3aGljaCBuZWVkcyB0byBiZSBkb25lIGluIGNvcnJlY3Qgc2VxdWVuY2Ug
YW5kDQo+IHVzYWdlIG9mIGJ1aWx0aW5fcGxhdGZvcm1fZHJpdmVyKCkgY3VycmVudGx5IGVuc3Vy
ZXMgaXQuDQoNCldhcyBtb3JlIHdvbmRlcmluZyBpZiB0aGlzIHdhcyBzb21ldGhpbmcgVXdlIGhh
ZCBoYXJkd2FyZSBmb3IgdGhhbg0KeW91cnNlbGYsIHNpbmNlIGhlIHdhcyBwb2tpbmcgYXJvdW5k
IGF0IHRoZSBkcml2ZXIuIEJ1dCAoYXNzdW1pbmcgaGUNCmRvZXNudCBlaXRoZXIpIEknbGwgYWRk
IHRoaXMgdG8gb3VyIHRvZG8gOikNCg0KPiANCj4+IElmIHlvdSdkIHByZWZlciB0aGF0IHdlIGRp
ZCBpdCwgZG8gd2UgY2hhbmdlIHRoZSBkcml2ZXIgJiBzdWJtaXQgdGhhdA0KPj4gYXMgYSBzZXJp
ZXMgd2l0aCB0aGlzIHBhdGNoIGFzIHBhdGNoIDIvMj8gT3Igc2hvdWxkIGl0IGJlIGEgc2luZ2xl
DQo+PiBwYXRjaCB3aXRoIHlvdXIgc3VnZ2VzdGVkLWJ5Pw0KPiANCj4gRmVlbCBmcmVlIHRvIHB1
dCBpdCBpbnRvIG9uZSBwYXRjaC4gSXQgaXMgc2luZ2xlIGNoYW5nZSB3aGljaCBpbXBsZW1lbnRz
DQo+IG9uZSBuZXcgZmVhdHVyZSA9IG1vZHVsZSBzdXBwb3J0Lg0KDQpJIHByb2JhYmx5IHNob3Vs
ZCBoYXZlIHNwZWNpZmllZCwgaXQnZCBiZSBVd2UncyBzdWdnZXN0ZWQtYnkgb25jZSBtZXJnZWQN
CmludG8gYSBzaW5nbGUgcGF0Y2guDQoNClRoYW5rcywNCkNvbm9yLg0KDQo=
