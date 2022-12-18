Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61F064FE26
	for <lists+linux-pci@lfdr.de>; Sun, 18 Dec 2022 10:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiLRJ3a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 18 Dec 2022 04:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLRJ33 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 18 Dec 2022 04:29:29 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B276CD2D8;
        Sun, 18 Dec 2022 01:29:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbuPYxGEKccrIa443ty1pS8slghcmh8OWEahS98L5p94v8hplbmk+2jpXDm2u5Tsqv7YBjvB3kYQlOy8c3041RkN9Iaqf06C91wfMXXniAOkhE9W+WjsPd5VZa3Bc4Oujqx0i2C2lcD94r3d/vtNMB6rNY+HeFU3ooDYy3PtDCD+ifcJllUJgrlRZpRcaIbYZJe9YKGJAL/hQXSRzLXZUHFts755G66qmX9tzQ+x9miJVKAprpK1rQzMwUIPx/EUx/u1xQEP7/R8vRiqVZXg3SCmzqCc5rYRYJbKHVwxavJBMSpDZEmjdFwRUeTs1clGcWcxrOed3zI/F8bj2OuzBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ni/HcgUJj4jYluQH/iNqEn08LIAfMCD6DCOQpZE5A0=;
 b=hmxvpDgtylz0C3Q2t9ljDeHVTD6czmnVr6uaeUD+euhoNB7hfIGNYQsgd7+Jg8glaTQyIfUOuG/M4Od1UYT7ZQURpd02H5/rgLyuU3NGMBeMxxgCbNhcYfWOuUN6Ij98PnNMRf6qyGW7sQE7ilV4VEJCi6J94qwsQkJcfO8g4lw1j22SlnIYPz7Cv/vfVNSh+aPNpeAXra1pCpAndioPlpb5yltkQykcaTd35wcZff61LjV+TXSrMiivAyq0qZ7i4qHe+ETLyc248rT24pSlHXE7Hg70RdyOgy49oHYlk27Z3qgN4E0CAsxOpc8gz9QAijY4YMFcDbnrfqGke0VUSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ni/HcgUJj4jYluQH/iNqEn08LIAfMCD6DCOQpZE5A0=;
 b=hgE0F1k3YC7g5DmKIQIKGix7jbYuKdpUajd1orALICBmzp+p8WtvhmJz6jXs18/6dBge/e4bGABg9XlNlKzfWrVJovfVtCS/eVYpaY5/gZHoYOsbprxf5wvI8hFLtI+kuAWXYyueVZTlNV9PoGUCxwNqziuG2iLz9CEHyONPIUumMebVgpJkX6T40xrobZGf5Mr6PXySUi8xnfOFr67/NeL5y3lPzwzlOQP92JhUN0DqzKCi2jLG7d7wqIYiGo0SKv8GjBwqFfOBgdpOYo9zeCHavjpxgnUUWbyrKkPSkzivNbKtomAuEk55k+AjGZSrWQgJnoqLkMfV1ZO9Ih6oLA==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 IA1PR12MB8221.namprd12.prod.outlook.com (2603:10b6:208:3f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Sun, 18 Dec
 2022 09:29:25 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::70c6:a62a:4199:b8ed]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::70c6:a62a:4199:b8ed%4]) with mapi id 15.20.5924.016; Sun, 18 Dec 2022
 09:29:25 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: dynamic MSIX submission plans
Thread-Topic: dynamic MSIX submission plans
Thread-Index: AdkSwhlrQ+m8PjHmS1ipW7AraIwGZA==
Date:   Sun, 18 Dec 2022 09:29:25 +0000
Message-ID: <DM8PR12MB5400783BA8E864AC3DA47BD0ABE49@DM8PR12MB5400.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_|IA1PR12MB8221:EE_
x-ms-office365-filtering-correlation-id: 07918edd-7cb8-45cd-9b3a-08dae0da5acc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0f0B8Bc2KsT6ByELaNQENxR+/ogfSnbbLuxyTAK4jceQgvMdnjtOymq0UDYBhmIImqHsLFh2rNvlay5Cfiv8nJVsPv9CytScz/AkD9xdqObUkXWRidR+PO14chSTGAHtASNb2u3ORlCx+d/KqtwR/0aLeVwgplXyjiiIBMcKpvHN3f+DVCY/q0EXKd4ySy3gKQy6D6LmXa6bRWw14/OkqINVhKD2I2a39hwNBjqhZcgOKJNp10bk71luuTZTBY3uq+zyZ6me5lMm84VxC0N+L0rSSjm9WUdEYTHn/UIQhJiVTEUB+xXF/Wl05Zr8e4/VvRoNdx59hnKDyDtS43bs2t95fzUk7Y6iD7Xr7tbBgok0VYKxILI/p8FmbOVfSAj8wT9exMSreusCJFROPnSAkBqxsTYij0XJEaVIbsfR43MXwFHe+utFPYL9cJVNbyfuXalpmYJkOM7c31Z1+rnshcLZufBTbFaoLoHWgywhstMtOYsMUXGXYGm8z9AgPC/3RLLOFKUWpliPHS6QgromUEL4zSbza0gXdRuZvHKMjBjFse8YW1swhdCRM2ZREtu+H7d/1nSz2cuNc2Y8IRcH2c7ppynGZiMD+jfUzDFfZxX3ocJIGzsLtWIt9q4xl2WZ1Cs0SfdIwhJSnKJZOr4cmJs18sak0PzmWL021apoqMvezX7WY2leHzXbNBYhYvFr2Q4u6eS9SVE/5YL5SFMvUYxvNf9aA20fmRVmYHRvP4ekkkHUmKHPM/U6C/KBzlvUZGOIRoN9FhKBm7pwX+XYz1DyX22SiATfgxf/y2PMrXU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199015)(66946007)(76116006)(66476007)(64756008)(66556008)(8676002)(9686003)(26005)(86362001)(4326008)(186003)(478600001)(71200400001)(52536014)(41300700001)(2906002)(55016003)(558084003)(33656002)(5660300002)(8936002)(3480700007)(66446008)(122000001)(316002)(966005)(6916009)(54906003)(6506007)(7696005)(38100700002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWdUN1ZkNXFFcWpOUFFTRVgwaXhsc3JXOERZbHZ2VFh1cXdiMUZCUklPU1BX?=
 =?utf-8?B?aHJqaGoxb3JUMDJ0WkRXbUd1S2tyZ1UzQlByODl3ZkUrVkhTMEdZT3haNWN6?=
 =?utf-8?B?Z1FsODZkR3V0Z1FSM1NucjBqRWU0WEZvTXFSTFVhWTZOazB1VmNxeXNnM0FR?=
 =?utf-8?B?WDFwbzAwMDNvakM1TGk4bWxyOEZ3WlhpbjJFb29YNzJuRFpDVGNLZjl6Tkw0?=
 =?utf-8?B?Ry9aK3JVVGFWeVMycWtHTHprSStXQ0xoY0RvZEFKb0VROFZjNzlmVEVDeTFL?=
 =?utf-8?B?Tm5ycWJYSXhudnRSb0dySnEzc2NSWHJqRXNoY0UwLzlRdGZOdkwzNDh2VEVL?=
 =?utf-8?B?SmY1M2pmeE5RSDBDcjlDaVlCUHFPemFLYWcvY2Y0VWl4TjMwZ2QxcWpib3dl?=
 =?utf-8?B?aWRoTm1nU2lWYnloVjVDRWtLMHNBZk9hSkVtcFM0RjkxdUdBUWRYV3BETVFy?=
 =?utf-8?B?aGpiLzlDSzRmbFVlTzN5WkFaY29XaVFEaHBLSSsvOXpGTmJpcHpDYkJBK0Y5?=
 =?utf-8?B?ZzVFUTgxUVBXZytBWVhCS3VkL1ppK3h4L3dDOHdBQ3JTalFPNFp4am1WZGxH?=
 =?utf-8?B?OGFkNnVpRDNSR2dvdllZWDJ6T2V6NEJvMzQ5a0Rkd20wdjVnWllRbDJMVWN5?=
 =?utf-8?B?YW02QXRGd3JJeURLMFhjOHE1ZUJtZGJhTjE0anNRSUFGTFRuZHprTFRjU1lm?=
 =?utf-8?B?MDJSUU9sRjB2bWNCRm9seStCZ2RKeG93bnhncU1JR3FMSkZneVRiUG11WDlT?=
 =?utf-8?B?ejNDc2RFbVRjTG9GaEQ5d3BtYXVXQ1lnclZ0MFdwbVdNem83Q04yeTlZS2lD?=
 =?utf-8?B?VmRsMStWNndMYjZBdVZ5TUZIdVRjSzREbzhhY3o0WUF2YmVCemVUeVkwUW9O?=
 =?utf-8?B?NW5MQnlxM1NwSlNlYWMzQ1JvNzFVbnYrSG5iOUM4WHlaRXZVSncyZlRWdzRO?=
 =?utf-8?B?NDh3NzExdXRSQklyVHRvMS9UTzU5bEo3NDBNdktiWjhBNVBrZSt1ZGdCdmg2?=
 =?utf-8?B?eHZlUElFY1lzbSt0dWhqYW84Ny9aK29jZ3pXU1JYYzZ0cndqdUFmNGhPdSt0?=
 =?utf-8?B?UTN3V2xoaDhoUDlnLzhaZ3ZBY21xRUJRU2hRMWRHVitWOXVjSHRjK1daYUd3?=
 =?utf-8?B?em5Pam9JRDFMeExaSGhJcnM4cVBYSWlyR3JlU3pXUmJRUm9OTnBFTy9RVmdX?=
 =?utf-8?B?YVlLTDV6TUU4THFOUFgvS0o2UzdBb3FjSWRpaFNneTVkSlZXd2l4Ni9jU3ZM?=
 =?utf-8?B?ZkRUZHZBRDREcmhvaXp3UmFvZGFmUlBTUmNVVWhtbDU0YVRhZFp4dW8reHZu?=
 =?utf-8?B?ZEI0bkVGUEhaQkxXd3NrZ2ViSFF4ZldHOGxFb0hVdG5tcTd3NUMzeFdLeEhS?=
 =?utf-8?B?bEVrUHhrMkxZaE9jQ1pXYXdzdEpNTXprdU9SSGZDTVljL21IVzIrZmxRL0t1?=
 =?utf-8?B?VHM0SDA5bUdlakxlNUx2NHk0cHNhMk8yVXoyOUx0V09MNkFwWWNZd2IrRlJW?=
 =?utf-8?B?VWh2ZDBNOWpVTmdNcHF2eC96Zy9SN29teENWUHlnV0VhTnd5NzlIdlZHVUM0?=
 =?utf-8?B?cFhCQVRuRE9NNmdpNFBxWDYzeWhGcngyN2pYeUN2Zjd6VlJiT1pJcjNReTcz?=
 =?utf-8?B?cFVzRkxjUE1FUm9oWVNlZFEyakI3MmtvZEYyZWE3KzNELysxam1OR01SZGph?=
 =?utf-8?B?V2tTTGloMnUwV21hSUFtWENPWG1uNnNNMDl0bDE3TFBwdDViV2NQS3dZQU8x?=
 =?utf-8?B?NFdPVCt0RWd5NTVPREJaNjJMWENMSXovT1B4ZDVBN1ZjK05qc3ZVM0U2U2NR?=
 =?utf-8?B?NVZONFh3a2hHd0FWN3ZFZ2VWRWZtTWdaQkM1ZktqdUdEb1RsOWMwQ3JJQlhW?=
 =?utf-8?B?cVU4Q09GdXBOWUFWL3pSMERldVRKaU5YanFqUlRaN2phbmRIVi81TmlDYlFx?=
 =?utf-8?B?RFJvSHVvbVhEdlVsdkVSMXB2OVFKdWFzVjkxaXBucmo3QWlNdGRGaE45Vm1N?=
 =?utf-8?B?MjNza2szc0ZraHAwNUY1RnNPMHBqVE9sNjFpVXZOUE5RQWFGRlBQckNYY1lj?=
 =?utf-8?B?clVUOUs2bUFMUzdQSjNudlU2cXlJSkN6c0JxVzNzcjZPOGthUFc1TnVCb2xF?=
 =?utf-8?Q?t+aw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07918edd-7cb8-45cd-9b3a-08dae0da5acc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2022 09:29:25.7041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H1hfSKWEKYnotAoto595S10J9BVSPjFUkI2df6CqFhWvqJMzbf86ICnqQmvNYGjE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8221
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgVGhvbWFzLA0KDQpXaXRoIHJlZmVyZW5jZSB0byB0aGlzIHdvcmsNCmh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RnbHgvZGV2ZWwuZ2l0DQoNCkNhbiB5
b3Ugc2hhcmUgeW91ciBwbGFucyB3aXRoIHJlc3BlY3QgdG8gc3VibWlzc2lvbj8NCg0KQXJlIHlv
dSBnb2luZyB0byBzZW5kIHRoZW0gZm9yIHRoZSBuZXh0IGtlcm5lbD8NCg==
