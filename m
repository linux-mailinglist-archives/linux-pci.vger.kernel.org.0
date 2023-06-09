Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71559729EC8
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jun 2023 17:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240954AbjFIPj7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 11:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241882AbjFIPjq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 11:39:46 -0400
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D59535A7;
        Fri,  9 Jun 2023 08:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1686325180;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JG5d7VBJm18VsvVUId+BS5dV04w/73odJHBXTYcbvQ0=;
  b=ZBaJ+wiMHHPuN//bjOdF8cfcMBaMCUFSiesJnPXRPXw4+TKe0dQ50YlX
   dazlL/QbVpU45jCl3neWLhGFQcIqQo8+OHOBBmX0GmZ3xL5FVzPHHq623
   gHrhn6tQCs/R0v5kZPsOnyOlXuygDEKSD3Q7jpdhCiR4HUhi08DTnsU3I
   k=;
X-IronPort-RemoteIP: 104.47.59.176
X-IronPort-MID: 112649613
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:oSzp4q/Xy9BWRcl7E4qJDrUDbX+TJUtcMsCJ2f8bNWPcYEJGY0x3n
 DYZDWrUPKuJYDD3fY13aYmwp04Hv8fdy4JqHAVl+3g8E34SpcT7XtnIdU2Y0wF+jCHgZBk+s
 5hBMImowOQcFCK0SsKFa+C5xZVE/fjUAOG6UKicYXoZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqojUNUTNNwRcawr40Ird7ks31BjOkGlA5AdmO6ga5Aa2e0Q9V/rzG4ngdxMUfaEMdgKKb
 76r5K20+Grf4yAsBruN+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+v9T2M4nQVVWk120c+VZk
 72hg3ASpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn9IBDJyCAWlvVbD09NqbDklvs
 uE2Og02NyzepMGa/aufW/Vwp+4KeZyD0IM34hmMzBn/JNN/G9XvZvuP4tVVmjAtmspJAPDSI
 dIDbiZiZwjBZBsJPUoLDJU5n6GjgXyXnz9w8QrJ4/ZopTWCilUujtABM/KMEjCObd9ShV3eo
 mvJ8n7mCxUeHNee1SCE4jSngeqncSbTAdtISuHpqKcx6LGV7ksVUDE7aF63mOSC11XlWP1uD
 lY/2SV7+MDe82TuFLERRSaQoHOAsRcVQPJTHvc85QXLzbDbiy6dB24ZXntZY90OqsA7X3op2
 0WPktevAiZg2JWfSX+Z+b6dthu9Pi8aKWJEbigBJSMG6tiloIw1gVTBQ9BsOKW8iNrzGDr5x
 3aBqy1Wr7ESi9Mbkqa251bKhxqyqZXTCA04/APaWiSi9AwRWWK+T4mh6Fye4fMeKo+cFwOFp
 CJdxJbY6/0SB5aQkiDLWP8KALyi+/eCNnvbnEJrGJ4isT+q/hZPYLxt3d23H28xWu5sRNMjS
 Ba7Vd95jHOLAEaXUA==
IronPort-HdrOrdr: A9a23:6oC7z6irLZoczSQPCW4DVZp4bXBQX+B23DAbv31ZSRFFG/FwyP
 rCoB1L73XJYWgqM03IwerwQpVpQRvnlaKdkrNhQItKPTOW8ldAQ7sSi7cKrwePJ8TezJ846U
 4kSdkENDSSNyk2sS+Z2njALz9I+rDunM+VbKXlvg9QpGpRGsJdBnJCe2Om+zpNNWt77PQCda
 a0145inX6NaH4XZsO0Cj0sWPXCncTCkNbLcAMLHBku7SiJlHeN5KThGxaV8x8CW3cXqI1Svl
 Ttokjc3OGOovu7whjT2yv66IlXosLozp9uFdGBkc8cLxTrk0KNaJ56U7OPkTgpqKWE6Uoskv
 PLvxA8Vv4Dp0/5TyWQm1/AygPg2DEh5zvJ0lmDm0bupsT/WXYTF9dBrZgxSGqZ12MQ+PVHlI
 5b1WOQsJRaSTnamj7m2tTOXxZ20mKpvHsZl/IJhXA3a/pfVFYRl/1dwKpmKuZEIMvI0vFiLA
 CoNrCa2B9iSyLZU5kehBgo/DXjZAVrIv7MeDl/hiXc6UkooJk+9TpX+CVlpAZmyHt1ceg728
 3Udqtvj71AVckQcOZ0A/oAW9K+DijXTQvLK3/6GyWvKEgrAQO7l3fM2sRC2Mi6PJgTiJcikp
 XIV11V8WY0ZkL1EMWLmJlG6ArETmmxVSnkjpg23ekzhpTsAL7wdSGTQlEnlMWt5/0ZH83AQv
 62fJZbGeXqI2fiEZtAmwf+R55RI38DV9B9gKdyZ3ue5sbQboH6vO3Sd/jeYLLrDDY/Q2v6Rm
 AOWTDiTf8wmnxDmkWI9SQ5d0mdCXAXp6gAYZQy19JjuLQlJ8lLrhUfj0i/64WCNSBC25ZGDn
 dDHA==
X-Talos-CUID: 9a23:36nddmGHRZUGG0EtqmJGs1M6CP0eK0GA71T8HlacGHp1aZe8HAo=
X-Talos-MUID: 9a23:WCCV/QZFydr8QOBTkDm0qBxfMctR/p/zExsOvqQjoeKnOnkl
X-IronPort-AV: E=Sophos;i="6.00,229,1681185600"; 
   d="scan'208";a="112649613"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jun 2023 11:39:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zot4zv/8g7SK1HZOAS5tUsFzkIPvDAjFoAmlf+aVXsLNvmzRzoPqpPO2JISzQytCFMEM1H4sLFFWCxyo+8duWOgtCWxZ+t9sDPaO/L2+AuzVDmMRvaYUJP0BE+5PBMrtcnkxowvhpdOGANzm2CbkOAPp+1zOAeVp50D39rbcVaGRrNICJ4XOqINIEA8eTi+tzJdl0rGXWLVC6gW27RO4Sh8ITutiPAYnQkrfKYm6BckZ3U0oLJ/swoeAxho13HQQsARiaPzLfWIQ7MUfq57PDKBW5l5qb4AHBWOGOl+iUMXmQjh3GgUHPIKDNgBxRTF6f3C94NxdOsmOBX5aYfYyvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPyb8XtdP/AmxkyiErNTpD+puj1VvX6RvYracQSpQA0=;
 b=W14f5/eKioNvyEfAHh5xKz+0NWzmm618psjxYPxmBg7ndN/8AixpugGFvuw6yTooXF6bxS7dlN9Q7Y9be4N/6Sew1EekZGQvlZ1mz5m6P3jNDViaHJVNEczls5SHIvVhnsTAbp628EuIOisv4m1HC5Y0VfxzPdD3A54AAxi1HH1PGtY0ZRwM+WlHevfa621hlFJzmyKF5+6uMpZC2dQl08NzhkKc4HjQv1ihNkCgBBSqVM/WBM5LHN0AMWHB3KkXL/3ffYlr/9RVs/naUp9zw9pWLS5BsHBKG4PLUYXnVMhlYnGDlP9xpvIfMXsUN3bHtNXt++ytme7F5hSWUO7pSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPyb8XtdP/AmxkyiErNTpD+puj1VvX6RvYracQSpQA0=;
 b=JENIvr2GkXW4zjnVRXH/M96K8sWTIh87zYDMXizYDnlHztp6NAZeFDpsYHKchzy1c6y61VfP3udbKLNFxEAR2LFqMroXfVyGCdf/i3Jp/RF1lLXjNzAgIU7cnykooVX3cacDFTpjkq9gkTmD5yICkEUasqtyLEr1R4w5iEnor7E=
Received: from DM6PR03MB5372.namprd03.prod.outlook.com (2603:10b6:5:24f::15)
 by PH0PR03MB6707.namprd03.prod.outlook.com (2603:10b6:510:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 15:39:35 +0000
Received: from DM6PR03MB5372.namprd03.prod.outlook.com
 ([fe80::bbf:868:7b79:bb29]) by DM6PR03MB5372.namprd03.prod.outlook.com
 ([fe80::bbf:868:7b79:bb29%6]) with mapi id 15.20.6477.016; Fri, 9 Jun 2023
 15:39:35 +0000
From:   Ross Lagerwall <ross.lagerwall@citrix.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Release coalesced resource
Thread-Topic: [PATCH] PCI: Release coalesced resource
Thread-Index: AQHZjx4x1rti9d7x6kmI75Onmzf//K9+cFyAgAQ7Q4w=
Date:   Fri, 9 Jun 2023 15:39:35 +0000
Message-ID: <DM6PR03MB53722DA6DF0E5D4E43C40753F051A@DM6PR03MB5372.namprd03.prod.outlook.com>
References: <20230525153248.712779-1-ross.lagerwall@citrix.com>
 <20230606223613.GA1147805@bhelgaas>
In-Reply-To: <20230606223613.GA1147805@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR03MB5372:EE_|PH0PR03MB6707:EE_
x-ms-office365-filtering-correlation-id: 6a1e59b9-d87f-4e31-68b8-08db68ffba51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5e9SwcGcUQMi60ZxMdKvVy6fYI2BvzDpwpva0TugSYeydC4odrF8vx9VUBYJEcqVToLO8WGvq3/+c4z75Gqg3t9iePLdAyLEOAguy1SCe08FoIN9S/BjovNvDHxTzOPodnLwUUgwaR1iyXoD89g7BOKl7sDBX44pA2enXIOrY5gAsRRhSbLragUoPLf724ljfNd1QBT24vFetvzppV+BfNaMkRSB0PFx66LMDko1O4cqHGMS0U2PaGyqOlCE++ZGWlepi236FhtEdrgSYCSqvQqUZQQLuezUqChvmLildBKKCWZMeI+Xn4dpyIie918nE4fsXB1b0JlsedijkUMsG1Yyu+T4Owv9XvB1/HcK6ars8vdI/RcvU5ozkYOCrR/S1uafeMLP/IAuY+Ur195Dko4GteL+aXCiqhTgQ3BHDBo8/QWjaKINgbrKIg7gR2qBwvLs66S3AXkiD8USrCsr5LYZ14KbXwomZNf3l9qk+6I0Q9i5frw9meib0/V9V58m8OX10BSiy6HYtbzls63TNy3G6MnJlfQMOEu3OsyAD/eYSAQ9UrXaNNYdP597q48zgY6aUHUkOwkQU6JVdGZcL8971qaD+CIm40grG6qbLuyjQ6qdR/k9wzCMnFmTFfRlR0n29JBXjrKJquhJuu+I0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5372.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199021)(8936002)(6916009)(66476007)(66556008)(66446008)(64756008)(76116006)(8676002)(4326008)(66946007)(91956017)(316002)(5660300002)(41300700001)(54906003)(52536014)(55016003)(44832011)(2906002)(478600001)(45080400002)(38100700002)(122000001)(82960400001)(53546011)(26005)(9686003)(86362001)(186003)(6506007)(71200400001)(7696005)(966005)(33656002)(83380400001)(38070700005)(10126625003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2rKluzb9/4R/G3SiH3hxe61i4P06p0IUiisaMxNxYdiCKohqkr0a+QpfZL?=
 =?iso-8859-1?Q?LJ10yYaLmgJuR3qTLb7M2xPDAGJlUeIf7W86uY2DW5+cRksIQfd+uUa2IZ?=
 =?iso-8859-1?Q?R4dC9SDIQ4n90FzRMvFBypf+liuczou+FiB9UFQPq3RQ3xSSaLZU2bBB6L?=
 =?iso-8859-1?Q?otDfSav4HasatYnK+GMi1AFgRSV5KL57sG26xxDfJQ0orlObNNP2NgOiZu?=
 =?iso-8859-1?Q?9VA+S7rXITXC7ickiDk8eTWrerfmKdSUmaRgufpBvhGE47lUoqvvzTU6bM?=
 =?iso-8859-1?Q?6L22S22XXgQQRDBePU6xSN0Jhe/UXvVcKtaj9SkEVevO167KsdUzJSGJrl?=
 =?iso-8859-1?Q?sRhbKY7dHOaxJQbre32Bg4EWb+CUdeEgxCXeP0GevRbWXeU6px4PYdSFAM?=
 =?iso-8859-1?Q?Vulg66nndM832VIXDq6KmEXAlW9W/l7AcBnNuJFeh8PK27S/WUddEd2qgn?=
 =?iso-8859-1?Q?PYMX+2TFAojteT2D+pLpMrlYdWHRqZgfEqESRVrA2ne/f1qdhA25wns6MJ?=
 =?iso-8859-1?Q?8o278ETR5mg55D6j6IH/a3Acu1p5SqjMH7lMOKn83EUbznTXYJT5N9cz1K?=
 =?iso-8859-1?Q?8zor8bT3NtG9C1fE51QV1Ju87mFYKVFAmkMjZoA3avNtJewPlJ99V/niKC?=
 =?iso-8859-1?Q?w/GBW623kV3EAyk2iqGth3XknACYXUXVPH+GQl9uOOYbb1Hjg1anDOGKgn?=
 =?iso-8859-1?Q?HdrDSMOcCTzXCg2UpkYZwtt6bl0mca4x9i5zwIYl18iSIK571WBgasHMVI?=
 =?iso-8859-1?Q?kLbBdMHiPdaHFDMrVb8epD54yrYeIA29IytkNiI06JTTiB24B7Hd6vIISc?=
 =?iso-8859-1?Q?s4FLBome53syE4YFBJ74NeDAAwZozg589/6bccpuamjFCCnFsE4VlmzyDd?=
 =?iso-8859-1?Q?SdceJwhCXx8lNDemqDVjAQFhR4PSSnckmSiSg9GtssEr0pVdnbblsRAHTi?=
 =?iso-8859-1?Q?fUj0EVszoQmH164lro/i0wLkX/mz70lCp4pY4GAu+n6ijY4UUfIEBj5Yd8?=
 =?iso-8859-1?Q?zFWuVVW0UUzZrnimPfQiIxckGSsgL/lUqeptyKNEDstjvOnyKoxR5PNPUf?=
 =?iso-8859-1?Q?WMTQ56RMfXa+5wJcYnoou+jhqHkxtdoNV6C99otpT8WggbPw+bzD24uEL0?=
 =?iso-8859-1?Q?MTD/7uneNoZDtTE+3KDtC7dBLM1mEcBCABkDcBLHfIeoJVcZ/KCA2EEm6c?=
 =?iso-8859-1?Q?O9smc0hmHFrWLewOLuT16sve3YkypMRtk6BJZ0CuFqHqJG0UEXdxt/xgjD?=
 =?iso-8859-1?Q?kVKfZkltVKAKA/U05r/O93FXzsUEAdSLXM/ayNNO0Qa0BcfqmcNiHLdZUs?=
 =?iso-8859-1?Q?kpch2QhaoOaXD4e2q1brUoBL9LlOuTc3/o6Qamkl2ZC+draEPsCG/354WY?=
 =?iso-8859-1?Q?Km/zBE65Tmv6Euo5x4sLritXMmNQVlwwMpNd7NS1fbB0Oq+l2slMu66nX2?=
 =?iso-8859-1?Q?afB9buVdRSMw44YAs7awCyECpqXjLCfXxpH1onJlRVh09yHYZZm7jMjQeS?=
 =?iso-8859-1?Q?/5iUbDw1obfmH5hxJdi4A/Q4237W3yv9lTgZARbtuGxS2Zf0U68JzSIIJs?=
 =?iso-8859-1?Q?T8uBD1I7vvyUC9iX05ge/vx6aivPySZBYimsUpDHp75577UUCFYn14ckZy?=
 =?iso-8859-1?Q?4k367IsLZpX484lfvE9bUka5G1yTVk+7jE?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wndFDVh5vqQpWgV344t2d8SyH4yZ3f7PGI1ZZqi2V5wmKc9+51NIZeZcuZmZVZ7kgQJRHiWI4T84zO13zjtYECQhmgkWK6PYHKBeyCH1zzM77jmLdrzQ9NAUxdkvVHttHE3Kb5vLLTuycwYrx+GEREEoHmqpl3dgLxRJvXF4ZJ+4ZYT3nqkRyRqBfRabouxVsZFpkQxgOHV/tl0EAPWG2yahiLP+PRaqVoss8J0bxifj/gz3FjIfPZ/90TnurIHde3k+Flyz93+W29tAzBt1XVTE9j2vCnQT5f72D7BW/TkW9Rfzr77ExHChpMdrQa9BL6gC+H8vX1mjhFexMqKwRvOK+wB7asxgp2wlu5miben8nkuOX+FmxfLSKdaD85IJMe58e0OgyGWrQEqKr1YA368yvmNJNAqIooRJcF3sAuUUoeOwcgymrvyi8c/i2b2pNwOxRi4VsY3IfeJhpwzwPHEywD9mghx2dRRD3J8siauHQYBhr9dP1PRTzC3QyTz9az6rsxd2QWknpHSubGqNwEkXZ34u9QlJ4Os53Ozi+a+IuqOD6NvdM88POYHKmP+kP9xux3McGBhwd3eD295iBB18z+rQCHqGKQcPCl4KiJkVo9jzqF8g1P5R/+GvIAa8ofYKJN9f4LLwu4hPVTQUNqRY/CFN3XA55Tanzj8ZarmnYUynfwIYNBzXF4lM1A1yBcQFZG+bEPc8ouBHm+sr6jo4aQlyUbSZ0CM6uRDNCFS18S1Wu1Z3f/pTZELdKitySo4TIvAt3OrmlOi+K47Es1UeERU+sSDAjItwxB6fVBM0LCa38fg+86PWu4bL8hqax1OMwDqHxsn1EFAJI5KJzpylfSOFKxy348qMXJ7VVJw=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5372.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1e59b9-d87f-4e31-68b8-08db68ffba51
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 15:39:35.4638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dOY/OTckm59nTrgZJjOqfRl+j6QFnO+S6d6jtrE5p0/o8uSp36GYOMkWvior7rjGxBTMb9vUo8otU/62Qup+tZM7O6rhrBs5yfF9Ct7X0l4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6707
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Bjorn Helgaas <helgaas@kernel.org>=0A=
> Sent: Tuesday, June 6, 2023 11:36 PM=0A=
> To: Ross Lagerwall <ross.lagerwall@citrix.com>=0A=
> Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; Bjorn Helgaas =
<bhelgaas@google.com>; Kai-Heng Feng <kai.heng.feng@canonical.com>; linux-k=
ernel@vger.kernel.org <linux-kernel@vger.kernel.org>=0A=
> Subject: Re: [PATCH] PCI: Release coalesced resource =0A=
> =A0=0A=
> [CAUTION - EXTERNAL EMAIL] DO NOT reply, click links, or open attachments=
 unless you have verified the sender and know the content is safe.=0A=
> =0A=
> On Thu, May 25, 2023 at 04:32:48PM +0100, Ross Lagerwall wrote:=0A=
> > When contiguous windows are coalesced, the resource is invalidated and=
=0A=
> > consequently not added to the bus. However, it remains in the resource=
=0A=
> > hierarchy:=0A=
> > =0A=
> > ...=0A=
> >=A0=A0 ef2fff00-ef2fffff : 0000:00:13.2=0A=
> >=A0=A0=A0=A0 ef2fff00-ef2fffff : ehci_hcd=0A=
> > 00000000-00000000 : PCI Bus 0000:00=0A=
> > f0000000-f3ffffff : PCI MMCONFIG 0000 [bus 00-3f]=0A=
> >=A0=A0 f0000000-f3ffffff : Reserved=0A=
> > ...=0A=
> =0A=
> I assume the "00000000-00000000 : PCI Bus 0000:00" is the problematic=0A=
> part?=A0 Is there anything in dmesg that shows the resources before they=
=0A=
> were coalesced?=0A=
=0A=
Yes, that is the problematic part which gets removed by this patch.=0A=
=0A=
dmesg doesn't show the resources before they were coalesced, but I=0A=
captured the output of /proc/iomem with/without the coalesce patch=0A=
to see what was being coalesced.=0A=
=0A=
Without coalescing, this region ...=0A=
=0A=
  fec00000-fec7ffff : PCI Bus 0000:00=0A=
    fec00000-fec003ff : IOAPIC 0=0A=
  fec80000-fecbffff : PCI Bus 0000:00=0A=
    fec80000-fec803ff : IOAPIC 1=0A=
    fec90000-fec93fff : pnp 00:06=0A=
	=0A=
... gets coalesced into:=0A=
=0A=
  fec00000-fecbffff : PCI Bus 0000:00=0A=
    fec00000-fec003ff : IOAPIC 0=0A=
    fec80000-fec803ff : IOAPIC 1=0A=
    fec90000-fec93fff : pnp 00:06=0A=
=0A=
> =0A=
> Is there an error message we could include here to link the problem=0A=
> with the solution?=0A=
=0A=
The error shows two "clipped" messages followed by a BUG when starting a VM=
 under Xen.=0A=
Having said that, I don't think the error is specific to Xen - it just does=
n't=0A=
handle getting back an unexpected resource range.=0A=
=0A=
[ 2783.654292] clipped [mem 0x100000000-0x3fffffffffff] to [mem 0x230a07000=
-0x3fffffffffff] for e820 entry [mem 0x100000000-0x230a06fff]=0A=
[ 2783.654311] clipped [mem 0x230a07000-0x3fffffffffff] to [mem 0x100000000=
00-0x3fffffffffff] for e820 entry [mem 0xfd00000000-0xffffffffff]=0A=
[ 2783.710864] memmap_init_zone_device initialised 32768 pages in 0ms=0A=
[ 2783.711124] ------------[ cut here ]------------=0A=
[ 2783.711127] kernel BUG at arch/x86/xen/p2m.c:542!=0A=
[ 2783.711166] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI=0A=
[ 2783.711177] CPU: 1 PID: 1795 Comm: xenconsoled Not tainted 6.1.27+0 #1=
=0A=
[ 2783.711189] Hardware name: Dell Inc. PowerEdge R815/0272WF, BIOS 2.8.2 0=
5/21/2012=0A=
[ 2783.711200] RIP: e030:xen_alloc_p2m_entry+0x57d/0x930=0A=
[ 2783.711222] Code: 3d 90 41 41 01 73 5d 48 8b 05 8f 41 41 01 48 8b 04 f8 =
48 83 f8 ff 74 59 48 bf ff ff ff ff ff ff ff 3f 48 21 c7 e9 68 fb ff ff <0f=
> 0b 49 8d 7e 08 4c 89 f1 48 c7 c0 ff ff ff ff 49 c7 06 ff ff ff=0A=
[ 2783.711286] RSP: e02b:ffffc90040d37d80 EFLAGS: 00010246=0A=
[ 2783.711297] RAX: 0000000000000000 RBX: 0000000010007fff RCX: fff00000000=
00fff=0A=
[ 2783.711308] RDX: ffffc90040d37d98 RSI: ffffc9008003fff8 RDI: 0000007fc88=
de067=0A=
[ 2783.711318] RBP: ffffc90040d37e28 R08: 0000000000000000 R09: 000ffffffff=
ff000=0A=
[ 2783.711328] R10: 0000000000000000 R11: 0000000000000000 R12: ffffc900800=
3fff8=0A=
[ 2783.711337] R13: 0000000000000000 R14: 0000000000000001 R15: 00000000100=
08000=0A=
[ 2783.711358] FS:  00007f295754f740(0000) GS:ffff888230640000(0000) knlGS:=
0000000000000000=0A=
[ 2783.711370] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
[ 2783.711379] CR2: 00007f4c6344cff0 CR3: 0000000105e46000 CR4: 00000000000=
40660=0A=
[ 2783.711391] Call Trace:=0A=
[ 2783.711401]  <TASK>=0A=
[ 2783.711412]  xen_alloc_unpopulated_pages+0xa6/0x430=0A=
[ 2783.711429]  gnttab_alloc_pages+0x11/0x50=0A=
[ 2783.711441]  gntdev_alloc_map+0x1d2/0x2e0=0A=
[ 2783.711455]  gntdev_ioctl+0x261/0x540=0A=
[ 2783.711466]  __x64_sys_ioctl+0x8a/0xc0=0A=
[ 2783.711480]  do_syscall_64+0x3b/0x90=0A=
[ 2783.711494]  entry_SYSCALL_64_after_hwframe+0x63/0xcd=0A=
[ 2783.711506] RIP: 0033:0x7f2956a875d7=0A=
[ 2783.711516] Code: 44 00 00 48 8b 05 b9 08 2d 00 64 c7 00 26 00 00 00 48 =
c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 89 08 2d 00 f7 d8 64 89 01 48=0A=
[ 2783.711536] RSP: 002b:00007ffcd8292e88 EFLAGS: 00000206 ORIG_RAX: 000000=
0000000010=0A=
[ 2783.711549] RAX: ffffffffffffffda RBX: 0000000000001000 RCX: 00007f2956a=
875d7=0A=
[ 2783.711559] RDX: 00007ffcd8292e90 RSI: 0000000000184700 RDI: 00000000000=
0000c=0A=
[ 2783.711569] RBP: 00007ffcd8292f30 R08: 00007ffcd8292f5c R09: 00007ffcd82=
92f58=0A=
[ 2783.711579] R10: 00007ffcd82928e0 R11: 0000000000000206 R12: 00007ffcd82=
92e90=0A=
[ 2783.711589] R13: 0000000000000003 R14: 000000000000000c R15: 00000000000=
00001=0A=
[ 2783.711602]  </TASK>=0A=
[ 2783.711608] Modules linked in: arptable_filter arp_tables tcp_diag udp_d=
iag raw_diag inet_diag netlink_diag ebtable_filter ebtables nfsv3 nfs_acl n=
fs lockd grace fscache netfs bnx2fc cnic uio fcoe libfcoe libfc scsi_transp=
ort_fc openvswitch nsh nf_conncount nf_nat 8021q garp mrp stp llc ipt_REJEC=
T nf_reject_ipv4 xt_tcpudp xt_multiport xt_conntrack nf_conntrack nf_defrag=
_ipv6 nf_defrag_ipv4 libcrc32c iptable_filter dm_multipath sunrpc dm_mod cr=
ct10dif_pclmul crc32_pclmul ghash_clmulni_intel sha512_ssse3 aesni_intel cr=
ypto_simd cryptd ipmi_si psmouse ipmi_devintf k10temp i2c_piix4 sg fam15h_p=
ower ipmi_msghandler acpi_power_meter xen_wdt ip_tables x_tables hid_generi=
c usbhid hid sd_mod t10_pi sr_mod cdrom crc64_rocksoft crc64 ohci_pci ahci =
libahci ehci_pci serio_raw ixgbe ehci_hcd mdio libata ohci_hcd xfrm_algo me=
garaid_sas bnx2 scsi_dh_rdac scsi_dh_hp_sw scsi_dh_emc scsi_dh_alua scsi_mo=
d scsi_common ipv6 crc_ccitt=0A=
[ 2783.711805] ---[ end trace 0000000000000000 ]---=0A=
[ 2783.716538] RIP: e030:xen_alloc_p2m_entry+0x57d/0x930=0A=
[ 2783.716553] Code: 3d 90 41 41 01 73 5d 48 8b 05 8f 41 41 01 48 8b 04 f8 =
48 83 f8 ff 74 59 48 bf ff ff ff ff ff ff ff 3f 48 21 c7 e9 68 fb ff ff <0f=
> 0b 49 8d 7e 08 4c 89 f1 48 c7 c0 ff ff ff ff 49 c7 06 ff ff ff=0A=
[ 2783.716573] RSP: e02b:ffffc90040d37d80 EFLAGS: 00010246=0A=
[ 2783.716585] RAX: 0000000000000000 RBX: 0000000010007fff RCX: fff00000000=
00fff=0A=
[ 2783.716596] RDX: ffffc90040d37d98 RSI: ffffc9008003fff8 RDI: 0000007fc88=
de067=0A=
[ 2783.716608] RBP: ffffc90040d37e28 R08: 0000000000000000 R09: 000ffffffff=
ff000=0A=
[ 2783.716620] R10: 0000000000000000 R11: 0000000000000000 R12: ffffc900800=
3fff8=0A=
[ 2783.716631] R13: 0000000000000000 R14: 0000000000000001 R15: 00000000100=
08000=0A=
[ 2783.716648] FS:  00007f295754f740(0000) GS:ffff888230640000(0000) knlGS:=
0000000000000000=0A=
[ 2783.716661] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
[ 2783.716671] CR2: 00007f4c6344cff0 CR3: 0000000105e46000 CR4: 00000000000=
40660=0A=
=0A=
This was separately reported here:=0A=
=0A=
https://github.com/QubesOS/qubes-issues/issues/7918#issuecomment-1331763950=
=0A=
=0A=
I have the dmesg and /proc/iomem logs here (somewhat older kernel):=0A=
=0A=
https://pastebin.com/raw/8TQUp2uG=0A=
=0A=
> =0A=
> > In some cases (e.g. the Xen scratch region), this causes future calls t=
o=0A=
> > allocate_resource() to choose an inappropriate location which the calle=
r=0A=
> > cannot handle. Fix by releasing the resource and removing from the=0A=
> > hierarchy.=0A=
> > =0A=
> > Fixes: 7c3855c423b1 ("PCI: Coalesce host bridge contiguous apertures")=
=0A=
> =0A=
> 7c3855c423b1 appeared in v5.16, so we may need a stable tag?=0A=
=0A=
Yes, I think so.=0A=
=0A=
Thanks,=0A=
Ross=
