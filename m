Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8764A4F0E72
	for <lists+linux-pci@lfdr.de>; Mon,  4 Apr 2022 07:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241713AbiDDFGA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Apr 2022 01:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355325AbiDDFGA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Apr 2022 01:06:00 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3367D6319;
        Sun,  3 Apr 2022 22:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1649048640; x=1649653440;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AWpmv6TiVu4xktsznhktcKCtUr61rj35Hpy22hdbOwM=;
  b=BQ6HNvT4wBasoqDCeyJfGTnDs92lQoBM/+vO3xLCHLJ5fmDUhoGR+UPy
   UWvn8f1KzL4FC43F/ew12JmN3IMLCsSsVklSIEavyk7pDYdjuHKcy+wPN
   FZNXnPWU/N+gfDmyVrYsdVz+cSOgW+7lxSWElkoRCwJNKUWw9nTGiR+Ri
   Q=;
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 05:03:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+AUc7fWwwGIbTH/YRGm60cSYXkThkhPp34cs9NQpMPBoBaebvPZJT6PO0mbhi8rk8Gtw0JBa5xeSwbboZXjinK7xzzEYH3WgYyzDndgrXJ9hZXmSD+qS2+gVkBiw9Jl9nyxz3aou1QfsCq0mpYyJxW1sBpsuHMgOxd4XQ+Bb4yrHvnhRbRxgoFft6ozDDjsmkgWGu4UrtDqbr5LhUOPlyYiLo/EVzj8dauB/mCssIy3unbH4h4nZAwr3mabtZ8NHr3Pqjc5+2ZIl19UoZzG9Uf4hbP/0XkRuBzOavYsfEGIOVnei7DuJr9JF7b+f8lW4ELQgZwQrc9s58sxRsMKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWpmv6TiVu4xktsznhktcKCtUr61rj35Hpy22hdbOwM=;
 b=gfVQixoaMZO7ES5vgz9fY7B8r5Zivn89g41RP9EPhGAk0qQTr0zA+YjBUHgGKzE3jM3MrS5xM39Mc1IDsneYV6gciJhwxQY3VkctzUdOmzOBMGoy02f8kvDvV0qKcL4PyOxiXA1o72gy12b7S4lLnVhzrrlUzFkn+ouun3aBC6F/pzjnCn5rZxQ6i2rSav6ao5xyCLZPI1/zCSV+HX1TDThAWXQBV56n5dreO/GOw5y1XtDki4Mysmq9VmTbXbRCcZqPirytpRA+pbq0RzAkrifMwmSPLHpkActkMaitqd5KXChxZVl5vNmW8Zz5exUnm5rvksOhqSCuQuNiWO8ijA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CO1PR02MB8537.namprd02.prod.outlook.com (2603:10b6:303:158::14)
 by SJ0PR02MB8733.namprd02.prod.outlook.com (2603:10b6:a03:3e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 05:03:55 +0000
Received: from CO1PR02MB8537.namprd02.prod.outlook.com
 ([fe80::6866:db4:9aed:f185]) by CO1PR02MB8537.namprd02.prod.outlook.com
 ([fe80::6866:db4:9aed:f185%7]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 05:03:54 +0000
From:   "Prasad Malisetty (Temp) (QUIC)" <quic_pmaliset@quicinc.com>
To:     "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "Prasad Malisetty (Temp) (QUIC)" <quic_pmaliset@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v1 0/5] PCI: qcom: rework pipe_clk/pipe_clk_src handling
Thread-Topic: [PATCH v1 0/5] PCI: qcom: rework pipe_clk/pipe_clk_src handling
Thread-Index: AQHYPpMUBDjZHALjcEuzQBIduyatpqzX7eMAgAdXt3A=
Date:   Mon, 4 Apr 2022 05:03:54 +0000
Message-ID: <CO1PR02MB853744542779C0C2CD61C1E4E9E59@CO1PR02MB8537.namprd02.prod.outlook.com>
References: <20220323085010.1753493-1-dmitry.baryshkov@linaro.org>
 <edfff61f-02a0-7962-a72c-97ef5f14ba76@linaro.org>
In-Reply-To: <edfff61f-02a0-7962-a72c-97ef5f14ba76@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a74e2d1-23ab-49de-0540-08da15f884b2
x-ms-traffictypediagnostic: SJ0PR02MB8733:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR02MB87332888EB1E7DDD5D2CDFBB95E59@SJ0PR02MB8733.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jkUaIGBj8JMSMs9R2DrkVQy8exUeRkO9/ofOyDilNRu15m5DJ/ZQoQL7McY5e7hKAZWgy9YgBnU4omibQgdjfIgWVo3Bg0YTImvXo4lX7zlHPtHM/3CWvbE+7CbeHrkOQF0YN8jUtV/FTmHpvawPV2Kpysf5AsT+gXydTVzMVR627CY3nFq5T4D2HIuEP9Yuku60CSFvWP6ixutBaQfSfeR4UQlvbMhN6bUFlEQRiB9OHaVDWUqoSwwPGUTKfv8PNBoSQrmKr6YTz3VVG0lrQ2ps59GObC05pMoWL9PH7bUlOlKwEur7U/NKMNGnWJXIwIgUmKDATgfACJVgRjQ7tdr0+JVe2fGZd23Dr//SNqW5h3Gnae2kurb+NeRL5I0rGyIC/hdGESW18snsC6SYp6No3diICngmOyaiPJWrbEhT4xnqoA6XKZKd4Cp5wOR3PdYlm5reyuINCCVQizTa7N/QyUJ6wGsnsH8TAaUpcNLfHdVLNMfOvlnWqcjYNFQT3wu9Qhhru5vRdrebpqNZ6EcgMe9cuF4/1MaaNI3zzsqftJIJqicJgO/QePMioxxwW2LmWQosAp6th39w5Z7c+1mrZtJYnRKbJ8cM0ye1HE5Tx1WNdAxX/Q6vYnsWQ9fJDrTW7+Kp2XrJoPO/G8boBum7r9zxf/heOG3YLOdhK7VVV6VLToOgA4kQus8LaISgLdLKbjaqZGW27L4mkx9t8wsmUBpjSFfWbIqzvhQmNR0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR02MB8537.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(38070700005)(33656002)(316002)(55016003)(86362001)(66556008)(66476007)(8676002)(66446008)(64756008)(66946007)(76116006)(38100700002)(54906003)(508600001)(122000001)(71200400001)(4326008)(921005)(52536014)(6506007)(5660300002)(2906002)(186003)(26005)(7416002)(53546011)(83380400001)(8936002)(9686003)(66574015)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkF2Zmpkd0EvT0dYWjdOUWRvRzNmdlNDLzZ1NzJrNTJNWFdlODN3K0h3dFhz?=
 =?utf-8?B?UnFncno3ZHlXYUFzUjRWS0dKeGFJbThpNS9oQkVNN3V4Qi9tVUFLdi9xd0R3?=
 =?utf-8?B?UGZTdjVTcmhab1UzZ2NhQmgxWUxOR3J3dk9aYWZPV1FHVkFHcWNnN01tKzB3?=
 =?utf-8?B?WGZvRVFzTzRjY1U0eGVHV25ZRmRzRGJhNVErWERrUEtvVllnNGlud1BSTnZM?=
 =?utf-8?B?bGJpenNkUHhlSmVVQm9jMkZpbElYalE5cnN4WlAvR3puUENib05ZNU01T1Iz?=
 =?utf-8?B?OW9ac1BMblJjUzZMbElzZEZZU1Y1OTFSZGI0UDFHOXJaRFVLaUdFaHI4SjAz?=
 =?utf-8?B?VTFEanFseGoxY1JHZUg2QXN3NUtZb0RGY0lEZUFlNXJIRUlEalNYY1BvaE0w?=
 =?utf-8?B?aEpuWjNld29hWC81MFByMUp4MUxQeEd2R21tY2FWMnFYOTBoNmFqTkpKVVlt?=
 =?utf-8?B?TU9WMVpBTWJ0ZWtpd2M4L0ErTU9sUHhSK3hWMGdpWnVGaW9tbkppWEI0WkRv?=
 =?utf-8?B?Rk1LUTNrZEYwdGE0TXgyQlBHOERzMENjWkprSU5qS25kRmF0VHRGUnZoTFFz?=
 =?utf-8?B?Q1RoNWhtR01aWkJobFoxbG5zR1F3ajhoR2Q3dVlCM2ZYZG55RzRRQU8wQ2Er?=
 =?utf-8?B?bXo5Unk2NWxTQmduMXVSMnNJV25MTmJkVzZXRmNrUWtnS2hsVDMxby9qMjRw?=
 =?utf-8?B?ZXk3bEVEVW5vdUlySzJESFMvRFdVWWIycUVoNlpqeWdSVkU5elBOWW1GRkU4?=
 =?utf-8?B?MHlYYVJtZThIZ1JnME4wa29HNjUvRjVpYUFZY2p5Sk9oYldxbGtWRGVKM2hU?=
 =?utf-8?B?czlGanNic2RkVU8rRzk1ZEFIbS81azVFZTdUNUFmY05SYzF3TlluRkpFQS9n?=
 =?utf-8?B?ZnlTRlJEb1pHRDdBc2ZVc0lONnRMbGM3bUYrUUU1TGxBZUhMYVlDRDdNS0Ja?=
 =?utf-8?B?WlN6dzRjSXovZkpacmRxUXFiSWQ4eERtcCt3dUU2QjFQV281bmtGMHhmUGRt?=
 =?utf-8?B?am1KdTI4MGZOTUhDdzhJTzVaVXhJTTdvM25kUjIyYlpEWXZSZmhNRDNUN2FP?=
 =?utf-8?B?V0tSUHNRZ2l2RC9qSDZZSkNnUFpVK1hhZWVSNkFZSWFNeEtRTnhja3UrNHpw?=
 =?utf-8?B?cG1GSEI5OHc1V3VKM3JCNnNoaWJrR0poQUlWaVMvWWthMjNJZCtYcm81WFJ0?=
 =?utf-8?B?QW5ha0VBRXcwZFpaV3gyc251b2hjU0lpRjAyQWxaQjFSUFl0dW10ejR5UDA5?=
 =?utf-8?B?N0MzRUc0TE1vNVFYZHJyVEZ4eEt0Q0c1UmJITWNPVlNwNnY5ZzVocExWME1o?=
 =?utf-8?B?U0l4UnozdDRjbGZ2WURaZFlpb3VBSTFiUTN6VzBlZ0hXZitTaGtJODJPQVlT?=
 =?utf-8?B?VVIvV2FyTlQrSUtLdDAveVErdEtWMDU0Nys0akJpNkEzd29EdzdPRWdwTUFI?=
 =?utf-8?B?dHZqTVhRYituVlUzS1poS2xUODRmMUxFcDVsS0JBQ3g4TThaa2pnY0NrZ2Y2?=
 =?utf-8?B?RmpGQ3hHclhsdE5CTmFKcWs5bXdyV3hyZjhETVhrZVVoNTRURzBNK0FUeW4y?=
 =?utf-8?B?NW5XandOeEk1bkI3UEtkeTdCbzh6NnpXM1M5cnlIR3lDYVk5dnZNTlRBZ3Ny?=
 =?utf-8?B?WER0M0ZKemRTTGtYc3JCN0Q2NFRpV01IbGF4VTc4RUVidkZGZVROMHVwWHY5?=
 =?utf-8?B?QkJHOXYrL251THBlOGpmSGt6NjVmTm5lU25WUzdTU3R1N0pDVW5hSWp5T3dL?=
 =?utf-8?B?NGF2OW10RkRnQzlkcGg3UVJqb0xlTE5MNnc0MDQ2cGZMWU5yNE4yZDJiZW5O?=
 =?utf-8?B?a3NxS0Z6bmdLYnNOZndCM2RwbWJEQ2FQdkNHSnVTTjdNUFZPZjBZWGpkc1NT?=
 =?utf-8?B?K0Mwa1Q5OEt4RXVGclZpckMwT0lJMjJQU2Uyd2Y0aGpZbmozQk83UzA1UExt?=
 =?utf-8?B?aHFweGxkbTA2cG81Yy9VOGp6aU40cEtGZ0xaN2h5VmN4bnA4amtiSC92YkxY?=
 =?utf-8?B?Yjl6YmxObm9iN0k0VVBueUVzYnliMGxrZCtPZlJPMDJQY2JyMk5xUVZsZzUr?=
 =?utf-8?B?N0tsM2wxN0d2ZmJGWmExbDl0VG8reUJ2Tk1sVlRuNlZCV0ZVSlNHeElmS2dV?=
 =?utf-8?B?ZzhuTVBpRlZqUzR3OEozNTFzVXpvelpPWmFwRUtFeS8rV2YzeTdINmlyTHlJ?=
 =?utf-8?B?WEV2TEgwRG1FNzc5S0hCMkZRYjQ3a2RDVnVIaVJIclN6dVpOelMzd2M0R1Nx?=
 =?utf-8?B?RURGOWtmcnh1QnBKbWgzUXdSZ1FiL28vK3B4MVY2V3NIaHI0SXJqSXVUQmhI?=
 =?utf-8?B?NC95a1NjdXp5eUo2TnNzMkwzdERlR2tScDNhTlVWVDdFM2pLTDRtdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR02MB8537.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a74e2d1-23ab-49de-0540-08da15f884b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 05:03:54.8365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QXo1LDZd5iE27wQybdVrA1hYrpM1aCA7FN7xYo6dZU9hl1I6FVxo4ZML7OZPxlfis+uWBhWZPST3LV1DPDoGM6L3zbROiA9MYAnteIREI/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8733
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgRG1pdHJ5LA0KDQpQbGVhc2UgZmluZCBpbmxpbmUgY29tbWVudHMgYmVsb3cuDQoNClRoYW5r
cw0KLVByYXNhZA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERtaXRy
eSBCYXJ5c2hrb3YgPGRtaXRyeS5iYXJ5c2hrb3ZAbGluYXJvLm9yZz4NCj4gU2VudDogV2VkbmVz
ZGF5LCBNYXJjaCAzMCwgMjAyMiA2OjI2IFBNDQo+IFRvOiBQcmFzYWQgTWFsaXNldHR5IChUZW1w
KSAoUVVJQykgPHF1aWNfcG1hbGlzZXRAcXVpY2luYy5jb20+OyBBbmR5IEdyb3NzDQo+IDxhZ3Jv
c3NAa2VybmVsLm9yZz47IGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnOyBTdGVwaGVuIEJveWQN
Cj4gPHN3Ym95ZEBjaHJvbWl1bS5vcmc+OyBNaWNoYWVsIFR1cnF1ZXR0ZSA8bXR1cnF1ZXR0ZUBi
YXlsaWJyZS5jb20+Ow0KPiBUYW5peWEgRGFzIDx0ZGFzQGNvZGVhdXJvcmEub3JnPjsgTG9yZW56
byBQaWVyYWxpc2kNCj4gPGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20+OyBLcnp5c3p0b2YgV2ls
Y3p5xYRza2kgPGt3QGxpbnV4LmNvbT47IEJqb3JuDQo+IEhlbGdhYXMgPGJoZWxnYWFzQGdvb2ds
ZS5jb20+DQo+IENjOiBsaW51eC1hcm0tbXNtQHZnZXIua2VybmVsLm9yZzsgbGludXgtY2xrQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtDQo+IHBjaUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2MSAwLzVdIFBDSTogcWNvbTogcmV3b3JrIHBpcGVfY2xrL3BpcGVfY2xrX3Ny
YyBoYW5kbGluZw0KPiANCj4gT24gMjMvMDMvMjAyMiAxMTo1MCwgRG1pdHJ5IEJhcnlzaGtvdiB3
cm90ZToNCj4gPiBQQ0llIHBpcGUgY2xrIChhbmQgc29tZSBvdGhlciBjbG9ja3MpIG11c3QgYmUg
cGFya2VkIHRvIHRoZSAic2FmZSINCj4gPiBzb3VyY2UgKGJpX3RjeG8pIHdoZW4gY29ycmVzcG9u
ZGluZyBHRFNDIGlzIHR1cm5lZCBvZmYgYW5kIG9uIGFnYWluLg0KPiA+IEN1cnJlbnRseSB0aGlz
IGlzIGhhbmRjb2RlZCBpbiB0aGUgUENJZSBkcml2ZXIgYnkgcmVwYXJlbnRpbmcgdGhlDQo+ID4g
Z2NjX3BpcGVfTl9jbGtfc3JjIGNsb2NrLg0KPiA+DQo+ID4gSW5zdGVhZCBvZiBkb2luZyBpdCBt
YW51YWxseSwgZm9sbG93IHRoZSBhcHByb2FjaCB1c2VkIGJ5DQo+ID4gY2xrX3JjZzJfc2hhcmVk
X29wcyBhbmQgaW1wbGVtZW50IHRoaXMgcGFya2luZyBpbiB0aGUgZW5hYmxlKCkgYW5kDQo+ID4g
ZGlzYWJsZSgpIGNsb2NrIG9wZXJhdGlvbnMgZm9yIHJlc3BlY3RpdmUgcGlwZSBjbG9ja3MuDQo+
IA0KPiBQcmFzYWQsIGNhbiB3ZSBwbGVhc2UgZ2V0IHlvdXIgY29tbWVudHMgb24gdGhpcyBwYXRj
aHNldD8NCj4gU2luY2UgeW91IGhhdmUgc3VibWl0dGVkIG9yaWdpbmFsIHBhdGNoc2V0IGZvciBz
YzcyODAsIGl0IGxvb2tzIGxpa2UgeW91IHNob3VsZCBiZQ0KPiBpbnRlcmVzdGVkIGluIHRlc3Rp
bmcgdGhhdCB0aGlzIHBhdGNoc2V0IGRvZXNuJ3QgYnJlYWsgeW91ciBkZXZpY2VzLg0KPiANClRo
YW5rcyBmb3Igb3B0aW1pemluZyBwaXBlIGNsb2NrIGhhbmRsaW5nLiANClN1cmUgRG1pdHJ5LCB0
aGUgdmFsaWRhdGlvbiBpcyBpbiBwcm9ncmVzcyAoIE5lZWQgdG8gdmFsaWRhdGUgcG93ZXIgY29u
c3VtcHRpb24gYW5kIG90aGVyIHN0dWZmKS4NCkkgd2lsbCB1cGRhdGUgb25jZSBkb25lLg0KDQpU
aGFua3MsDQotUHJhc2FkLg0KPiA+DQo+ID4gQ2hhbmdlcyBzaW5jZSBSRkM6DQo+ID4gICAtIFJl
d29yayBjbGstcmVnbWFwLW11eCBmaWVsZHMuIFNwZWNpZnkgc2FmZSBwYXJlbnQgYXMgUF8qIHZh
bHVlIHJhdGhlcg0KPiA+ICAgICB0aGFuIHNwZWNpZnlpbmcgdGhlIHJlZ2lzdGVyIHZhbHVlIGRp
cmVjdGx5DQo+ID4gICAtIEV4cGFuZCBjb21taXQgbWVzc2FnZSB0byB0aGUgZmlyc3QgcGF0Y2gg
dG8gc3BlY2lhbGx5IG1lbnRpb24gdGhhdA0KPiA+ICAgICBpdCBpcyByZXF1aXJlZCBvbmx5IG9u
IG5ld2VyIGdlbmVyYXRpb25zIG9mIFF1YWxjb21tIGNoaXBzZXRzLg0KPiA+DQo+ID4gRG1pdHJ5
IEJhcnlzaGtvdiAoNSk6DQo+ID4gICAgY2xrOiBxY29tOiByZWdtYXAtbXV4OiBhZGQgcGlwZSBj
bGsgaW1wbGVtZW50YXRpb24NCj4gPiAgICBjbGs6IHFjb206IGdjYy1zbTg0NTA6IHVzZSBuZXcg
Y2xrX3JlZ21hcF9tdXhfc2FmZV9vcHMgZm9yIFBDSWUgcGlwZQ0KPiA+ICAgICAgY2xvY2tzDQo+
ID4gICAgY2xrOiBxY29tOiBnY2Mtc2M3MjgwOiB1c2UgbmV3IGNsa19yZWdtYXBfbXV4X3NhZmVf
b3BzIGZvciBQQ0llIHBpcGUNCj4gPiAgICAgIGNsb2Nrcw0KPiA+ICAgIFBDSTogcWNvbTogUmVt
b3ZlIHVubmVjZXNzYXJ5IHBpcGVfY2xrIGhhbmRsaW5nDQo+ID4gICAgUENJOiBxY29tOiBEcm9w
IG1hbnVhbCBwaXBlX2Nsa19zcmMgaGFuZGxpbmcNCj4gPg0KPiA+ICAgZHJpdmVycy9jbGsvcWNv
bS9jbGstcmVnbWFwLW11eC5jICAgICAgfCA3OCArKysrKysrKysrKysrKysrKysrKysrKw0KPiA+
ICAgZHJpdmVycy9jbGsvcWNvbS9jbGstcmVnbWFwLW11eC5oICAgICAgfCAgMyArDQo+ID4gICBk
cml2ZXJzL2Nsay9xY29tL2djYy1zYzcyODAuYyAgICAgICAgICB8ICA2ICstDQo+ID4gICBkcml2
ZXJzL2Nsay9xY29tL2djYy1zbTg0NTAuYyAgICAgICAgICB8ICA2ICstDQo+ID4gICBkcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXFjb20uYyB8IDg3ICstLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+ID4gICA1IGZpbGVzIGNoYW5nZWQsIDkyIGluc2VydGlvbnMoKyksIDg4IGRlbGV0
aW9ucygtKQ0KPiA+DQo+IA0KPiANCj4gLS0NCj4gV2l0aCBiZXN0IHdpc2hlcw0KPiBEbWl0cnkN
Cg==
