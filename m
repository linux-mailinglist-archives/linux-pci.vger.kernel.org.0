Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CB057D512
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 22:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbiGUUtU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 16:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiGUUtT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 16:49:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1788FD44;
        Thu, 21 Jul 2022 13:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658436556; x=1689972556;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mwlZlXkoiBOM9j4IA1JiRte24NMrPNpTb3QgPa45O8w=;
  b=NUOYMj77it2IsnzAxCVnxJe2MjYMRP+dJogqy7lhozre/z/QaFSrWg9c
   uiXn4zojJGrXoHQQFTNvH/sZ7HvZYALB3GFh/KTHMRHvadURhJBjU3qsZ
   aDkeVjJYahUoZsbTNmhQJJcTMWKfRs2oAQ0PaDNT9p9Y6mpFfEj52Jann
   QvMPpwFsHhQas32R+nqSMGig4DgSp3uT4rVDIWg8GmvZQTDW/yJuwI/bG
   ZelT9yRyP4iC1jTV00B1Jorwkh7BbEsYUfNHMDIkR+/G7VyZf4WjD341O
   O0WemlQFMD3eEd0FXod6WBuG5XLHW7bl/nXTgHlpJTNmcNEdPNqcjBYUI
   g==;
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="168977124"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jul 2022 13:49:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 21 Jul 2022 13:49:10 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 21 Jul 2022 13:49:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrU07kwVtTVJx+QlgG72EUe7WTF1bFSF7kNpvP087ANs7pvD5RoUUkdkuobgl1bn3X1z3Zi0XaByT5FhPaCTpQqmwRsAWVAmZSiO2dOPGayLUygX0IQGC6hgLS0c1IiHgAfxO687kWXXkhwhd+eJxOxWJoK4mPq80izypOCmxcWZsje/gKBjhrP2ErZEXmSeld0VDxLGXWMIEwlktElX9LfU3tBhGe5g6Ugp9EupJupsT7Afhtlpo2YLex2k1sKEQ8KlswsburHU96+DmR+NeGRt5TvABUwmsOuZ8dimQOWdDCLFoM56SBPRn11EoFNNmqrgcaqgcea1OlYDSRL+Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwlZlXkoiBOM9j4IA1JiRte24NMrPNpTb3QgPa45O8w=;
 b=PeOb8d/SaLIWQfcahs4wpul9FU/gJfFPJVhcd3LnItuH5iiwxEvSQmb2DWp/0e2c16Po9MkbkfhcpOgllkM29HbghU8ptpj5ppc7CUVRDSL6Ux37FC143C4H3ZPR0NcXLBV57nqbtgvzj/JfBA1EUwJQMl5oDxYSWpk5p0HqvkTPLDHhaCco4kpOejtca6zjrk//p9zWCaAIJQuduMQqi7teT50cGKwmjnmZ/ZGHv8d520gW2MdtLYztkYkLEozvpES1CuDs+qMElYaF61iubaRvPpl+2ioT6DV1nvWU35EaBvQQVhUB+2OEduh1hRTxRnDUVb8C6DB+XWsPEkxYMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwlZlXkoiBOM9j4IA1JiRte24NMrPNpTb3QgPa45O8w=;
 b=igq33ETgxzwoZfKtLXR9JXpQi+0qcRi9JoKQL0+M2oEnjJOEv0d4by7p+lSquj9HVH7heTIQpl4qhglfWINVnrHXd7H+5lcMyAicnrJgLD/JmN4e2JubaZNxe65Ks1eO0EZU39eROnwvTR9yAGO/X7b2syCS+LSYbrjZsojAPOc=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB3434.namprd11.prod.outlook.com (2603:10b6:5:70::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 20:48:56 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%7]) with mapi id 15.20.5458.018; Thu, 21 Jul 2022
 20:48:56 +0000
From:   <Conor.Dooley@microchip.com>
To:     <pali@kernel.org>, <helgaas@kernel.org>
CC:     <kishon@ti.com>, <songxiaowei@hisilicon.com>,
        <wangbinghui@hisilicon.com>, <thierry.reding@gmail.com>,
        <ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
        <linux-pci@vger.kernel.org>, <tjoseph@cadence.com>, <kw@linux.com>,
        <ley.foon.tan@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Why set .suppress_bind_attrs even though .remove() implemented?
Thread-Topic: Why set .suppress_bind_attrs even though .remove() implemented?
Thread-Index: AQHYnUNLaJTy2XV99UGqwEQ0U33kSw==
Date:   Thu, 21 Jul 2022 20:48:56 +0000
Message-ID: <7b41730b-9528-8a3e-138f-b7f0bdbc4910@microchip.com>
References: <20220721195433.GA1747571@bhelgaas>
 <20220721204607.xklzyklbgwcgepjm@pali>
In-Reply-To: <20220721204607.xklzyklbgwcgepjm@pali>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7ce2734-9178-40dc-5355-08da6b5a6e14
x-ms-traffictypediagnostic: DM6PR11MB3434:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: quZrryVq40dlB44Sq5X2mz05hOs8QL0DpKivfKrXAZ76FonnNYjjYcMh9HkfQtRADiiYVu/hkHWJ3kXw+wDhzfilvqfTDROGAo4t9obrTa2ecW+pFBZ20rkJn7Xyp+EhfyriefkItDJdknJA4CYsWQIu4pb8NjW11mF2OOzPRIOUcFw6Oj2bqCkja+Yx/V93hcldMVBubpzegG9CwxYdpN/GIYnFfGGwX1MpqBBmQvQowIPfB2yduCxdeOA72PQXua8CG0WTiEIIVVhVD6jXq1ZAY5nWL4gS1/1TtPP2uUsTcMBWDA3Zg8c5HMHCTOk4RIJxx3h5N8VZzg+ldU6WyonNCApUqfzely2KV3j2ylEuy2jdqYkJuRd42dkU/XzCezXRK4d1lKoEctDCcOOqwoCRnm6zeChCzsQ6bwKQrH0yVTOUhMVA7EO42PBT2UtN3bcjlHdRnNuetrU9rP6dnFg4sjTFYFeG7e3x5PYJHjSf/9iPPlDpqFBCDdXgvJ7rE+dYzi6H3BH1fXw+yNG/VKpYJucYm/+1Ebk2l4RgUFbeP9/sgmDcedND1CyCJPf8gpdO1upGSzm6oe+ffoPfd8lBXMWC309myj4OTeWaGrQMsDbFIkvN467GqBdJ63tMIVcCgtabqPCrsXnzlteVwi3HG239Chz/GeVRoPrHz+hkgJN1FksjIjXbkG9UIaWS190PkNNJlvVgi209WVeylCFLu+rfN9AI21VouswqvHLa2nj/BYKKPnD+WxZAvmXxnzgvXgPgaBXBID1qESYDBiiHwP50Eab8Dmd6MasQMZfRf0KJLoZawxavKw47XrpAKI6qFryaPi4fewErceZrs4cHU+VVYdTRrtUk2ixtzmFxwJFiQWq9Z7YpQ4fBV00NeVPxAM6L5lM88zA2w4uR794pQq+BdSbnZKOeI6hPIlc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(136003)(346002)(39860400002)(396003)(478600001)(8676002)(2616005)(110136005)(6512007)(54906003)(31696002)(86362001)(38100700002)(91956017)(66946007)(64756008)(76116006)(122000001)(316002)(38070700005)(66556008)(66446008)(186003)(4326008)(66476007)(26005)(4744005)(2906002)(53546011)(71200400001)(966005)(7416002)(5660300002)(6506007)(8936002)(36756003)(31686004)(6486002)(41300700001)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFZjamF5b2txa1h1UnllaDFIdWFLaWJ0d1RsZGZlTGVpUVAwdS95cWZyek10?=
 =?utf-8?B?aXRMcENXL1J4eTNnckxVSkgwdHVSZzJQcDUxK09TUWYwY251d280NVE0SVVV?=
 =?utf-8?B?RnI5eTl5RjVFQ2dYVWNLcHd6OEFxcmhUYVN4R250YlBRZlVVTDNBOUJmbjN1?=
 =?utf-8?B?VUxxaGlrSTFBdnc0QzdXMDJyVExiQmkyMEVEVExGRWxKK3g5TkJUZ2N6TDZi?=
 =?utf-8?B?aGY0REpodDhWTzlHOU4wbWphM2I1K3VzaW95U0VvWEpRMU9oYXM2ZGFUSVlQ?=
 =?utf-8?B?ajBwQkwweHYwb2JHNGNydElsK0FBSnN5WUFzZVRBRzVwb0hlZldWMTBjcnNs?=
 =?utf-8?B?cFQwNXhOenAvUzZhekJBMnBqWXJXV0p2TDhKa3MvRXBNZHlhN0VrRFFHU3Q1?=
 =?utf-8?B?ems0cUxidUU1eUZJZ3dHYW1MNmp1TGE1cmhEMS9Fc2RUaFUwRXE2SFFFMmRi?=
 =?utf-8?B?NXkyVGhhcCtKTUdad3E1Z2JTZ1BsWUJjYUlSL0VndEFiTXp6U1BRS1ZMSk1w?=
 =?utf-8?B?REF3ckpsWklSblJHbGZjQU1ycFFSWFFYWXlZOTNyaC8xT2NrYkNCNXFKUXRG?=
 =?utf-8?B?cUp3NHB0RzdyWTRoU24yVGs0MHdqWUN6K0hLRC9sb0pYZGordE5ZbUdXQ2pZ?=
 =?utf-8?B?eVQxV3FTSDJpY2x6R1hBaUpvYTFPMWZvLzhMMlgxS2RzVHZldXZXc0JJM3JV?=
 =?utf-8?B?M1BFalRXMDB0cldtMEdqZU8rN01BVFJ4YXBRV2xkUVIzWmMwcEozaGlPRUY0?=
 =?utf-8?B?NHpmV1krR0hzdHF4akxUejYra3RKVmc0ODhGMHUyS2FPc2JFeHZHcDhqOTNs?=
 =?utf-8?B?b0cvM3YrQ2tYYkZOVXFuclZVUVEzK291SERGVC9HNncwSlF5Vzd6a054Vm50?=
 =?utf-8?B?L1p1YUtLakJTRitGMVh0aG9pblk0ajd0OTZFaXorUE1kV1BDVEdqaWdocCtY?=
 =?utf-8?B?QW1LNDgrT0pvcm9XWHFhK1R2OFZvS1ViVzlUQndMME5ITEFHYUNWSldVcEwx?=
 =?utf-8?B?YlFIeTYwUGozcC9yVU1udXMxRDBSSm1NOFYzbVdJb2VBaTZnWTNGMjJyL2pw?=
 =?utf-8?B?YWZodVBrMTIwVy9PQmM1b0k2MXE1SUhIMmliNjVCYk9sdUFIeE9taUFsNFpF?=
 =?utf-8?B?WWdPRno5Q3kvcHZFNzZrd083NytSbm16UUdQc0YweHA5SFI5NUkwRmZ2QktG?=
 =?utf-8?B?RzRsWFZEaWpkVmZ4bHkvNkRjRHhzSVpqeUt4WW9FazNzTG94Unl5NjVvaFdh?=
 =?utf-8?B?RkNtaTZaYVJQb1ZaeVlhWFNlYllXd1l2dmVUYjM2dzR3ZG5kNUkrR1pyeGd1?=
 =?utf-8?B?SEdTS2NrdDY5ZWxONWFnY0gydEFkSXJsby9UL2pjN01kMERrQTMzUTlBOUdF?=
 =?utf-8?B?T0tZV0NqUnRkM0JXM0haMHRjQm8wV0hDcmY1bEF4bldJdzkzajFYRFBHRDkx?=
 =?utf-8?B?OWJ6VlRNN2FKL2hIWWQ1elpiYk9aUDZKU1JORnR0VEdSRVQxRFJnWFJYcnZo?=
 =?utf-8?B?VGF4RE5nTzdhamk3eFZZbVVia2ZoSVlpNWdTcjBvQXVFS1ZWWnk0ZStwQTlr?=
 =?utf-8?B?QUdOZXVHZU1WV0o5MWNub0NqS1h2T2tQNDlxOWVCQzYwcm1QRWg4dkJxeVlI?=
 =?utf-8?B?c1BDNW1TZFN1bmlNS0lBRW5hUHZSeWFJUStnK04wTjd1eEtBZVhKYWtULzQ1?=
 =?utf-8?B?UmdEb0lHMjM0cUZQeFNXSEZPR0hGSnFyWnRwVlZQSVE0YXFkNmVUWllMaHlj?=
 =?utf-8?B?OEFCMmNFM2tGdWtyWHNySWVyZlFkNnFBZGNpWjJrOGxwQWp6ZEVvbm9mQndC?=
 =?utf-8?B?djdxTHZUaC84aFluN3RKNmU1Z1R4cXhDajhrTXdIUmNtc1pBeEdMbHFoN3Bj?=
 =?utf-8?B?NVRNZjlMOXVnWDI1azRKVjk2NGJhL3RzZndVRWdNSzY2V3NzejVYM0NaRHVT?=
 =?utf-8?B?Y1JuMThSNXJUL1dBZzlyVmlxbnV5QWRvQmppKythRHdwaDdvTGtURGZhQi81?=
 =?utf-8?B?aWdxTHp0Vy9QRzRxSEpvU08zQzlyY0lLNTYwbmE0ZVZJcXBuNm9uWk1kanNw?=
 =?utf-8?B?dnphU1k5QmQyeklyYnUxQ2EyZkhKcjg5UEg2dGZVcm9UcVdERFB4akdtNXQ5?=
 =?utf-8?B?UTNEUmJYenJEZ0pkUHN2akc1ZTNIWUI4a0FCMUZObXFrQ0xJcFd2ZVF4a3Q3?=
 =?utf-8?B?d3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9ED49360B38BF545AE425A0C5E844D28@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ce2734-9178-40dc-5355-08da6b5a6e14
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 20:48:56.4088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LbxpbrhzIq0T786EPaVp5M9Hqiy3AVpTrG/uJqfHy6CGzjZx7Jby3kN6Em1nC//Ou1suXYgbUJ99g5b5FAZ7W6nxMSE7dNvQrucOboqRORQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3434
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMjEvMDcvMjAyMiAyMTo0NiwgUGFsaSBSb2jDoXIgd3JvdGU6DQo+IA0KPiBNaWNyb2NoaXAg
ZHJpdmVyIHdhbnRlZCB0byBjaGFuZ2UgaXRzIHR5cGUgZnJvbSBib29sIHRvIHRyaXN0YXRlDQo+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXBjaS8yMDIyMDQyMDA5MzQ0OS4zODA1NC0x
LXUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZS90LyN1DQo+IGFuZCBhZnRlciBkaXNjdXNz
aW9uIGl0IHNlZW1zIHRoYXQgaXQgaXMgbmVlZGVkIHRvIGRvIG1vcmUgd29yayBmb3IgdGhpcw0K
PiBkcml2ZXIuDQo+IA0KDQpTdGlsbCBwbGFubmVkLCBidXQgb3RoZXIgdGhpbmdzIGFyZSB0YWtp
bmcgdXAgdGltZSBhdG0NCnVuZm9ydHVuYXRlbHkhDQo=
