Return-Path: <linux-pci+bounces-2539-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46CB83BA7A
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 08:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 930D42827C4
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 07:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501FC11720;
	Thu, 25 Jan 2024 07:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="03wRxQ+t"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB168485;
	Thu, 25 Jan 2024 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706167050; cv=fail; b=CVs9bV6aHjfut3TAgPbZ8+ytGhf0mRITpUbr0KyunyM/e+yW5zfShVey6hjsqKIwUlfGkCmwKz0vpcK6D2OxtOiWsIp4IymT8dONhOMDu8kkfVBf8HyAlqX3J+M3gNaQnzv8RvbmZKPmoQVD46Fy0YsmBL0+J16QJSpnRSVYdMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706167050; c=relaxed/simple;
	bh=pqatrYytfLKiPk2v/ZKyHk0/71bcH/0KTHfFL5H2apo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m7jBGWazpRTAk85VXOuNPwyiNc0owm/v3oSCwIxTNgt+pf8/YpjV3PQDgqMMfHbZSxy+xM76tdJku5cNl+LRQ4OFBYGpEkAXCA8AD3ESkreKOAWN2eP0PpbtAYSlLaCbna08vhoAru3q5n8eydbjo3CuA+rRUf+VgojIROBMXUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=03wRxQ+t; arc=fail smtp.client-ip=40.107.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObyP+T/+PeOdRtHKXtEJB4ncG88TqdQH9up6eKFEjdnFvsVYYYVN8J3Fvrky1MhhjRGuym3QfXEesBpvRpb/JTbkPOnAGPX9aQD53+s4bmm4URYeSKfttNLtP54lNS7eMg8iideuTxyyJ40Wpv2dpDN+v6EgoD9POBHtX3JN+REx6rv9Z6OJCAYPlOOpfZtU9gu8/ajeK0uMjDFMqEFQ3hvrFeUnLareJgWJI9ICJ0s9tFw8INyJDRY/yTUEodbF9ciigtJVO/IlBTchDm6vzbp1pXHo+3khEsPiBRGvqTqcrM5HbIsNAAMwrflgLmwiG+DlVM+SrM/Ca5z2+EbHIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqatrYytfLKiPk2v/ZKyHk0/71bcH/0KTHfFL5H2apo=;
 b=AXFkSrc3Td5lhrE9C9EwQ8vIrXcK31aWLX89o5oFRTwj8M0u5vaDX74oi8pgPjzNKK+b4YhIRluG9Is0hhk+GEplVHmMk+n9hBl3+3zJ3Ki8l9IOecqn8oj/ZCE81iL4uE+LTfIeFV6cNKHWBMJiI883doO019tNog7eYlMj7a8uZFGsrW7gx68ow3hUNB2D5ikQqKgEuTbJfhfL3PDe395ouYZyS9hvuagCU889OHm8jFIxIgcoxUfT1qGma7a8KlYKnObZ/XI9+Dn220Dz9U6OiKH9SGXensjIJ/sh8OXAae8fEsJZPupADqA04IR92kotRQrG+x4jcXF/nryFcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqatrYytfLKiPk2v/ZKyHk0/71bcH/0KTHfFL5H2apo=;
 b=03wRxQ+tdRLcpodjTNYuHUx4w9nJZzHD2bI2Ola6NEeA6RHLQaA+keqbffnKqeQpxnKz1pJs/H+JTKGhRlOG9MUpxmptL1kIm/TkwqzGLnvAU/c9MMbIvrQwVup3vLg0jWj3VnZEw6qzaCLrHAZHuxeBeByM3+vMXlGRJLGheog=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by SA3PR12MB8812.namprd12.prod.outlook.com (2603:10b6:806:312::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 07:17:24 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::bafd:1985:94e6:ef33]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::bafd:1985:94e6:ef33%7]) with mapi id 15.20.7202.035; Thu, 25 Jan 2024
 07:17:24 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Hildebrand,
 Stewart" <Stewart.Hildebrand@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
	"Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>, "Chen, Jiqian"
	<Jiqian.Chen@amd.com>
Subject: Re: [RFC KERNEL PATCH v4 3/3] PCI/sysfs: Add gsi sysfs for pci_dev
Thread-Topic: [RFC KERNEL PATCH v4 3/3] PCI/sysfs: Add gsi sysfs for pci_dev
Thread-Index: AQHaP5+doYjSbLzTtkiUcLxinuNXV7DmmK+AgAEHcQCAAAvdAIABnLmA
Date: Thu, 25 Jan 2024 07:17:24 +0000
Message-ID:
 <BL1PR12MB5849B51FADC8226764078A98E77A2@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20240123160252.GA316914@bhelgaas>
In-Reply-To: <20240123160252.GA316914@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: BL1PR12MB5851.namprd12.prod.outlook.com
 (15.20.7202.013)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|SA3PR12MB8812:EE_
x-ms-office365-filtering-correlation-id: a36db38f-0be2-45ad-0aed-08dc1d75ae06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 VrNxpmNvIT0O4BfVAEuumQml/jMSdoJkzPPabZGX4oig1IfqSQGSfChpnPQEWtlTD6eUojjq+6PYxu2N24UOgA7KYfYDpoeiMD+TuPmteCpf0ms1Cvg0V8DtGDbKwZgIXbX2pk40JkmKpuQ8XPOiJtaQaoRzjExnQKeaR9uVI51ioSMDGGWeOWJLDIDvPPR9RfroCALjkdyLbIjNQK8KHxAmWva+eVPbwFM8g8wC2cliUIb7CpeTJ6ZNJWx6prn/4u/nia1EirfUVxFfumzh6JRYTnJjIcARsIVKLAyE/aRd8e3mG8zKG3rQwsfxhlV7lBOCUoA4nCai5ksm+A9pfoOLGe0RvQheanAc5pQ107v1u7WWN27fKjXX2Cjvra4ljLmgRLLyag3ALWIU9JPjHzzFDTurHxinTt+oCjEW2N10qWkvzSA4hhElFlkpF977mCtYKgdqSMnC2fD4AiOABUYN4EU6H8Zqu804rHd/HXvD17d0H9SC96+WSxbc2V6yVMBbJ1vDxsN6KNmkdeAoU9Xrx0bj3l0p2t9c0DP2IAw1t01J0RBMraWUG3prB+QhTr+h8NzT08nUBZdiPzIj2O5SnnLunZheMOukHxHr77ETI6xcaFkLx3KSpPdlhKBC
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(66476007)(316002)(66556008)(66946007)(53546011)(64756008)(26005)(66446008)(122000001)(54906003)(6916009)(9686003)(478600001)(55016003)(38100700002)(6506007)(7696005)(71200400001)(8936002)(76116006)(8676002)(4326008)(52536014)(7416002)(5660300002)(83380400001)(41300700001)(2906002)(33656002)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V0FYNkdDaVd0NGlleGxvVFduUlduRTUvVE11dDhDamYwMEZrM0w4czNFTlFn?=
 =?utf-8?B?dGQ3ekNPSlhqeUlwTUQ2Skh6bythUmpNY2Vvenh6TUJCNWpMcEZlMXN3d2Fy?=
 =?utf-8?B?aHQrZG51N0lObE5mU2FLUTBPRStRaHZKQ3QzaFRuMnJxa0U5RndDZDNhQUFC?=
 =?utf-8?B?bTBFdjQ0cnlaYWJFc1RLMkd2WFIyUitnb3JpSmFsVEhpa0l0RzVmSFlXUy8x?=
 =?utf-8?B?Q3lxYmFnelc2ZWhycXU3MFZPM3ZQU1lsQXJtVEJTdWo2em01ZGpmSlU5TENu?=
 =?utf-8?B?VkxhbGpESkg4Z0wzaXdyOUt0S05GOVB5N01MZ1BiU0Y5dElOU0pWb2QzNkdv?=
 =?utf-8?B?YkpzTDg0a1J0SE1Gd1J1QXo0VW9BVTJRdkFoUGhHb1JtZXBobU5IRTJITGpu?=
 =?utf-8?B?ZlFaS3dqT1NlRmVLS0NyQlFlUjNpSnByZDZMaktkdDJIRys2UzdkTXBGWlUv?=
 =?utf-8?B?U0tSNU1mOXp2YWZDUnl6YmFaakFKb1FwZ29xYndVSThhM2NZbWRGR3hrL3Ir?=
 =?utf-8?B?cmxQSDJybGFOdzhkUFZwclg0bnJNd2RZQXE4V2Q2UGkyVkMrK3ZUZGQ5Mk1P?=
 =?utf-8?B?djBWSkt4N1lMbi9IaGFIczkxVWVLcVhxcFJvcGVVcjFFUlpiQVlUNTk1UFl0?=
 =?utf-8?B?S0Ewdmx0dVlVREpPeHhFK2VYUGVTbjJuYWhNQjFGUkd0a3cyQzhYNlBrVWlr?=
 =?utf-8?B?RTZBQWRCcGkzK3ZDMVQyOHZieWNneVZjWmtUWXJFYjhoSWJhMEZiVFJJMUV5?=
 =?utf-8?B?cWtqQ0NSakdMbnJlU3lDbThEVjZvT1RhWXZuWnNuZTNpQllSODZoMndUbzNB?=
 =?utf-8?B?WlI5bCtDWDhFcitpQ3ZYQU5jeUxWUktMOWhNT3lKSk4zcW5pTGlYcSt6bnky?=
 =?utf-8?B?OFFIVndJVUdOUTVWRDE5NlZiSURPMm5naEpYQVFtTjdJQ2EzWTNOK1lIbWtI?=
 =?utf-8?B?bXdrclFtTnhVRVZiVkdsL3VodUI1YVhsc0hsdUNqUmZhSFU5LzNvTi85VVJ3?=
 =?utf-8?B?bThMRkpsanFaKzY3YjdoMnF5STJ2aUVDYmRzamZOUXFyYlZ4SXFVeFA4aXdB?=
 =?utf-8?B?RXR2T0V6VXZad3lEMUtpMllCSExTNittdnhXRnpWblhhQ1JrbVoxcmROUU90?=
 =?utf-8?B?SkI4eXJWUGFhV0lIVlVMMHhWc20zaW9lbFhvam11NTFtdUtjRy9xaGpBTExQ?=
 =?utf-8?B?MmFUTG9rY29QRmVscFhxbnlCTjU5RVU3OVRabmVKYXIzaGtpQ1kvdlJLUEhH?=
 =?utf-8?B?RkJLT3Bwb1U2MkdwQzdmdHRPbFVaTkZVdE5IREpGMU5BRG1JTmxZM2VYWmVu?=
 =?utf-8?B?bVpaVUJ2RC9ocDFyZGJNQkIrVW1mWUFVK1VtQkhYWWtvUThhRDlYRXp6MFEy?=
 =?utf-8?B?eEo1TDYwSmZFWVhoeTJWbzhDQTN2MHhQRENYd3lGL1ZQWDRlUU90NFJYV2R4?=
 =?utf-8?B?STZJSGtRSlp0MThCdUZaei9ZTjZCYTBueXBSUmxHR2k1ZHNVeGYyRlpRNEt1?=
 =?utf-8?B?aVd5YzZVcWhuckRrNGNGaGtDNWEvTENuclhNZXVzYTlIREZ4V0psMFpoZ2Vk?=
 =?utf-8?B?R0c5ZmUwdVEvc2lSS2lES20wTXVxVHFvTE1ObVQyMGRnU3d4YzRYS2o0N3VD?=
 =?utf-8?B?RHUvQXVaK2ZVYzFNZ2diQjM4T1VEWVFWRmRqdE9MYlRTdlV4Q1BSQzJBUGFL?=
 =?utf-8?B?Z3E1M3dLNEVpRldJS0xYUjF2cy8wQk1HYXptSE1PN1oybGRXdFRjcXU5YzZF?=
 =?utf-8?B?SU55R1EzcDN4czNHRllvVHJqRnB3K3ByKzdHaTFGS3BBQVNITVRnSEYxandJ?=
 =?utf-8?B?THA4NWJvT0xqaHRHWXNCTmc2dzYySTY1a00rOTJlNW1mN3ZKN0k4QjlFSWQ1?=
 =?utf-8?B?SGQydnh5M3U1UTNCZWhCMHFucnliYVBuZHY5cXRXZE4vbFE4MjA5bk5YeElu?=
 =?utf-8?B?eWxtbUM3aysvY1k1N3A0ckgrcm9hOVhJTEpsZ0w3MTNJTVI2VHR1ZXpiQTFw?=
 =?utf-8?B?TG53VWJITzArOFZTZGN3RmRYZzA0RWJXUURoTXFiRjhOaUNoQjJWZkZ0SFpZ?=
 =?utf-8?B?Yit4ZE9zQjFEaUR6WEpMMG1kZ0R1S2dyU1hlbWM1YlRMcVRZRUF1K05IcFRZ?=
 =?utf-8?Q?tWFM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A0C0ED826A8FC4B9CD427BE0CDA7D40@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a36db38f-0be2-45ad-0aed-08dc1d75ae06
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 07:17:24.7168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wpX/ZJDyXtP/MfoAA29vKUvQsZNdB5PCanjMVRjGQcY6qLFx09TJJoAz34i6vBZMMS3lELRKd6L2LsrpgBA5Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8812

T24gMjAyNC8xLzI0IDAwOjAyLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0KPiBPbiBUdWUsIEphbiAy
MywgMjAyNCBhdCAxMDoxMzo1MkFNICswMDAwLCBDaGVuLCBKaXFpYW4gd3JvdGU6DQo+PiBPbiAy
MDI0LzEvMjMgMDc6MzcsIEJqb3JuIEhlbGdhYXMgd3JvdGU6DQo+Pj4gT24gRnJpLCBKYW4gMDUs
IDIwMjQgYXQgMDI6MjI6MTdQTSArMDgwMCwgSmlxaWFuIENoZW4gd3JvdGU6DQo+Pj4+IFRoZXJl
IGlzIGEgbmVlZCBmb3Igc29tZSBzY2VuYXJpb3MgdG8gdXNlIGdzaSBzeXNmcy4NCj4+Pj4gRm9y
IGV4YW1wbGUsIHdoZW4geGVuIHBhc3N0aHJvdWdoIGEgZGV2aWNlIHRvIGR1bVUsIGl0IHdpbGwN
Cj4+Pj4gdXNlIGdzaSB0byBtYXAgcGlycSwgYnV0IGN1cnJlbnRseSB1c2Vyc3BhY2UgY2FuJ3Qg
Z2V0IGdzaQ0KPj4+PiBudW1iZXIuDQo+Pj4+IFNvLCBhZGQgZ3NpIHN5c2ZzIGZvciB0aGF0IGFu
ZCBmb3Igb3RoZXIgcG90ZW50aWFsIHNjZW5hcmlvcy4NCj4+IC4uLg0KPiANCj4+PiBJIGRvbid0
IGtub3cgZW5vdWdoIGFib3V0IFhlbiB0byBrbm93IHdoeSBpdCBuZWVkcyB0aGUgR1NJIGluDQo+
Pj4gdXNlcnNwYWNlLiAgSXMgdGhpcyBwYXNzdGhyb3VnaCBicmFuZCBuZXcgZnVuY3Rpb25hbGl0
eSB0aGF0IGNhbid0IGJlDQo+Pj4gZG9uZSB0b2RheSBiZWNhdXNlIHdlIGRvbid0IGV4cG9zZSB0
aGUgR1NJIHlldD8NCj4+DQo+PiBJbiBYZW4gYXJjaGl0ZWN0dXJlLCB0aGVyZSBpcyBhIHByaXZp
bGVnZWQgZG9tYWluIG5hbWVkIERvbTAgdGhhdA0KPj4gaGFzIEFDUEkgc3VwcG9ydCBhbmQgaXMg
cmVzcG9uc2libGUgZm9yIGRldGVjdGluZyBhbmQgY29udHJvbGxpbmcNCj4+IHRoZSBoYXJkd2Fy
ZSwgYWxzbyBpdCBwZXJmb3JtcyBwcml2aWxlZ2VkIG9wZXJhdGlvbnMgc3VjaCBhcyB0aGUNCj4+
IGNyZWF0aW9uIG9mIG5vcm1hbCAodW5wcml2aWxlZ2VkKSBkb21haW5zIERvbVVzLiBXaGVuIHdl
IGdpdmUgdG8gYQ0KPj4gRG9tVSBkaXJlY3QgYWNjZXNzIHRvIGEgZGV2aWNlLCB3ZSBuZWVkIGFs
c28gdG8gcm91dGUgdGhlIHBoeXNpY2FsDQo+PiBpbnRlcnJ1cHRzIHRvIHRoZSBEb21VLiBJbiBv
cmRlciB0byBkbyBzbyBYZW4gbmVlZHMgdG8gc2V0dXAgYW5kIG1hcA0KPj4gdGhlIGludGVycnVw
dHMgYXBwcm9wcmlhdGVseS4NCj4gDQo+IFdoYXQga2VybmVsIGludGVyZmFjZXMgYXJlIHVzZWQg
Zm9yIHRoaXMgc2V0dXAgYW5kIG1hcHBpbmc/DQpGb3IgcGFzc3Rocm91Z2ggZGV2aWNlcywgdGhl
IHNldHVwIGFuZCBtYXBwaW5nIG9mIHJvdXRpbmcgcGh5c2ljYWwgaW50ZXJydXB0cyB0byBEb21V
IGFyZSBkb25lIG9uIFhlbiBoeXBlcnZpc29yIHNpZGUsIGh5cGVydmlzb3Igb25seSBuZWVkIHVz
ZXJzcGFjZSB0byBwcm92aWRlIHRoZSBHU0kgaW5mbywgc2VlIFhlbiBjb2RlOiB4Y19waHlzZGV2
X21hcF9waXJxIHJlcXVpcmUgR1NJIGFuZCB0aGVuIHdpbGwgY2FsbCBoeXBlcmNhbGwgdG8gcGFz
cyBHU0kgaW50byBoeXBlcnZpc29yIGFuZCB0aGVuIGh5cGVydmlzb3Igd2lsbCBkbyB0aGUgbWFw
cGluZyBhbmQgcm91dGluZywga2VybmVsIGRvZXNuJ3QgZG8gdGhlIHNldHVwIGFuZCBtYXBwaW5n
Lg0KRm9yIGRldmljZXMgb24gUFZIIERvbTAsIERvbTAgc2V0dXBzIGludGVycnVwdHMgZm9yIGRl
dmljZXMgYXMgdGhlIGJhcmVtZXRhbCBMaW51eCBrZXJuZWwgZG9lcywgdGhyb3VnaCB1c2luZyBh
Y3BpX3BjaV9pcnFfZW5hYmxlLT4gYWNwaV9yZWdpc3Rlcl9nc2ktPiBfX2FjcGlfcmVnaXN0ZXJf
Z3NpLT5hY3BpX3JlZ2lzdGVyX2dzaV9pb2FwaWMuDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KSmlx
aWFuIENoZW4uDQo=

