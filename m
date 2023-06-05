Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4999572214F
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 10:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjFEIpE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jun 2023 04:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjFEIou (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2023 04:44:50 -0400
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54526B0;
        Mon,  5 Jun 2023 01:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1685954687;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aDnBeKEhqy0lwkki5+yolktXzVpV8DKS91PKeVDg/RE=;
  b=ANUbctS2Rp3kuQWDKOqS/s3ScralAk7wrbt9btLFSZrPkQumItuZSiYH
   mjHMeFDCNER79meq68/Hogiy+4Cu8XDbU10f8BZUs3rLcP7NrZuymhuBc
   ayDxHV84gVU51Z8htcUPgq5y14BhdiLclXqZVKsglFUD/qx/ZDxTRPgit
   U=;
X-IronPort-RemoteIP: 104.47.57.175
X-IronPort-MID: 110347953
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:5hSr+Kp9Mf4Nw00paY1P6YrVOgteBmLJZBIvgKrLsJaIsI4StFCzt
 garIBmEO/eNNzDzct50Pd7n9EIDsJaHn9NnGlE9qy03QiobpZuZCYyVIHmrMnLJJKUvbq7FA
 +Y2MYCccZ9uHhcwgj/3b9ANeFEljfngqoLUUbKCYWYpA1c/Ek/NsDo788YhmIlknNOlNA2Ev
 NL2sqX3NUSsnjV5KQr40YrawP9UlKq04GtwUmAWP6gR5weAzyVNVfrzGInqR5fGatgMdgKFb
 76rIIGRpgvx4xorA9W5pbf3GmVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0MC+7vw6hjdFpo
 OihgLTrIesf0g8gr8xGO/VQO3kW0aSrY9YrK1Dn2SCY5xWun3cBX5yCpaz5VGEV0r8fPI1Ay
 RAXAGtKUgujg+O4+aK6SeMwmp4lDsnEbLpK7xmMzRmBZRonabbqZvyToPN9gnI3jM0IGuvCb
 c0EbzYpdA7HfxBEJlYQDtQ5gfusgX78NTZfrTp5p4JuuzSVkFM3jeeraYWIEjCJbZw9ckKwv
 GXd5CL9Cx4XLsOWzT6t+XOwnO7f2yj8Xer+EZXhr6Yx3ALCmzd75Bs+Ulb8gOWmmG6FSohfD
 E4b5BI0oOs26xn+JjX6d1jiyJKehTYYWtxNA6gi4wCl1KXZ+UCaC3ICQzoHb8Yp3Oc8RTEu2
 VaAhPvmAjtgtLDTQnWYnp+XpDL0OSUTIikMaCkLZQAM5d7loYo6ilTESdMLOKq0iMDlXDL92
 TaHqAAgiLgJy80GzaO2+RbAmT3Em3TSZgs85wGSUmf76Ap8Pdehf9bxtgWd6utcJoGESFXHp
 GIDh8WV8OEJC9eKiTCJR+IOWrqu4p5pLQHhvLKmJLF5nxzFxpJpVdk4DO1WTKuxDvs5RA==
IronPort-HdrOrdr: A9a23:3jHQxqDTM2lWtvDlHemE55DYdb4zR+YMi2TDj3oBLiC8cqSj+P
 xG785rsyMc6QxhI03I9urwW5VoLUmwyXcx2/h0AV7AZnidhILLFvAB0WKK+VSJcEfDH6xmpM
 JdmsNFZuEYeGIbsS+M2miF+rgbrOVvu5rY/Ns2h00dNT1XVw==
X-Talos-CUID: 9a23:0z8Ag21vVCIJOVwdnOm1jrxfQYcZaV3ZzXnpM067Azp1Eru3SXDAwfYx
X-Talos-MUID: 9a23:dE49+Ag4zT2l1dcggCE9ycMpM8ovwrixGmA2gM8GnMuLKxRqNnSZk2Hi
X-IronPort-AV: E=Sophos;i="6.00,217,1681185600"; 
   d="scan'208";a="110347953"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Jun 2023 04:44:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOnJ0HZlUmjzcdCof8EE1a+jnMeKfxc6Cy6e+nuqZFpBhCc4ZVm+nxkeGWpaBvI4W08RN8P5yjIg0X7LSytEz/FS2duIS4GQ5sGIZc3PUdMc5uvpaMYC4WpjtVArq4Yk01QduzP1Q6K9pcO9XfBSvM34NRRkGi4td+aV3HJk5nwDTK9AX53uRvv0gxFXj+C2oNT8jjA4RpPg8tnTri/8UGSlmB8frzuqLI6sL8wMQ2KnCua/HJF9Z5I25oyygc7RmNNRnHx2j6ErERhRgik2bqQkl34KJNCb0c5f6Sz1a0qEyV1Q0aM/67oGLvMmL381OPSZ0WsJjT9PNWCMDU4S2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDnBeKEhqy0lwkki5+yolktXzVpV8DKS91PKeVDg/RE=;
 b=BLGvY6YmDetahKqLBJLpV/CEuighAM/QiX7V6Un0ayWlVtnIOxQ6ud60l+z/SdpEo0SGKh2jd8fw791Mu+m3PyYfbtbRY2iTbZk3LXBrs79iCDDWSAAqrT8kFq8gNjcRf2yWNr9qMRsLjg5jjGAl4qpQ9fsE3SBEPNRNor9ZP7M4H6VNShEbXg2lLeQRtO3SewZCHLN68tM+geNpJ4LCwYCYXfE2NUnjokh+7Q82UBdS6PC5mrIYmbmdALoFJ31O71Z3W0t+/PFJ9sfD/USy/QCFf7phSRwrPT0HtzyCUyQArfEySXvxVdrrqxwLlVx36vXgGRmAQVOSJlWkCqrqlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDnBeKEhqy0lwkki5+yolktXzVpV8DKS91PKeVDg/RE=;
 b=m+oM/r0BWwb9URuD7945Zktwat050MAFnjbgtSnkBN6XNi19RGJ+aTQgdPtfGk8NQ/HQNxpYO9K8/mB07nkEXBNUq5PhwYDi5YPIOJfhZWejv3XMOY2K6I7SPlJen7sYz01gvkkm6SpazhlSFMHXqlqgTaiXskZYgTh68b0ILDM=
Received: from DM6PR03MB5372.namprd03.prod.outlook.com (2603:10b6:5:24f::15)
 by SJ0PR03MB5552.namprd03.prod.outlook.com (2603:10b6:a03:288::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 08:44:44 +0000
Received: from DM6PR03MB5372.namprd03.prod.outlook.com
 ([fe80::53f7:d006:1645:81e2]) by DM6PR03MB5372.namprd03.prod.outlook.com
 ([fe80::53f7:d006:1645:81e2%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 08:44:43 +0000
From:   Ross Lagerwall <ross.lagerwall@citrix.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Release coalesced resource
Thread-Topic: [PATCH] PCI: Release coalesced resource
Thread-Index: AQHZjx4x1rti9d7x6kmI75Onmzf//K9787wF
Date:   Mon, 5 Jun 2023 08:44:43 +0000
Message-ID: <DM6PR03MB53729AA409FA1DC12ABCBCDEF04DA@DM6PR03MB5372.namprd03.prod.outlook.com>
References: <20230525153248.712779-1-ross.lagerwall@citrix.com>
In-Reply-To: <20230525153248.712779-1-ross.lagerwall@citrix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR03MB5372:EE_|SJ0PR03MB5552:EE_
x-ms-office365-filtering-correlation-id: 0cbf033b-3ea8-422a-d637-08db65a11bce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B7E5qAJ4Aua3nZfZEHzxmofcYP0vh5QAFLfmfYAPjyJb9IlonTrnXzhlyEFlDpihSu806yfKpdSrDyw1o6QyTgInTMFhES9kIZ/nLidSfSGPtFKw/LnZ4eA43DpWPRPJIVbX59gU7CKt2PJUB/Rb4vbHU1HIZd7MEDaeJDDqbHj6AhOLf9IxG3te4yj4p9+Zl+4ywTJk3ElTkadp8sl16I3dirySFYfZUCIxMQgSam4qwbLyWbNe+kwJqDXXD5lL7IBSPX/64nW0eL0Jnxo3aCqnQhRWTI/IhTHa3tkSxBaMmoHDzes2trv602Igg/LrHh7180Qgj1x/JChQe21ygOGlSHdObcBAO7Ki5T2dxqecyYtlLwktesIrVoNZ4wv+wQhC87F64Sx9WPAOeM0DELi1EC0go1mYlwBkrou6LODEjvzxm2XGvUyRB5F+/4oRgdT5bZ8rYD5kTB0CiBfsQxtpd6vDYJyjdqZLUlUvUEf+WJkxOt+BfqlDwOYDMzujGFxRWWwltspymRVpcfzX20UvTWi+PBlXkgmQ1tC7olMAqUs5Bfck9j5t8xhx0LxJG3wxkXFFhMeyNMSo4zu3EqdwKhgYPycj1zxqlQr37LSETJbEnhvpZ132x5Xebib9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5372.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199021)(54906003)(2906002)(38070700005)(71200400001)(33656002)(478600001)(86362001)(52536014)(38100700002)(41300700001)(8936002)(8676002)(5660300002)(82960400001)(55016003)(316002)(44832011)(4326008)(6916009)(66556008)(122000001)(76116006)(64756008)(66476007)(91956017)(66946007)(83380400001)(66446008)(6506007)(53546011)(9686003)(26005)(186003)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9BGSz3fFE+9YK7kGRrmkb6ts90J7jFlY1BJByxN2o88BbIBYTkdikDk2N9?=
 =?iso-8859-1?Q?cXr1hY+ExXDnWCTwiT6AeTuqQLkyEPTNHlqVgckzNh6JdbytMyvJrXzRmT?=
 =?iso-8859-1?Q?UoMMfDWbEVNRGCsXpYXPMx4xVCw4mk0b4iehOSxsLxMqJDb0nSNO+alLgu?=
 =?iso-8859-1?Q?w3Kg3v5PTLRPX1ZO6Tll/0dtjLjtT7opy9pB2BloMHD5oAQOYy62DQywOh?=
 =?iso-8859-1?Q?5Ue32NFBQHtMb/FKhXtUmjYp5bNbiZpYmz2lF/PMPO+6Hmnjg0e60mgOIN?=
 =?iso-8859-1?Q?hvEv/I2fR5IxB//DgDutk4RitDT1Oksq/s4thzotxEjEhnYWnfMFYLvRt+?=
 =?iso-8859-1?Q?5jmiuHCjcV/zpkgaOS41drGvIpOkQHWut2Qi8nulbBr11fjCNby5vp/tii?=
 =?iso-8859-1?Q?OBt4DvU2nJyvifcPc5dDzcdPysgqyzhHCUqt7BPqMT8bXvaCIWvjqQRhB1?=
 =?iso-8859-1?Q?DriWYjneGwbFTFNzo1m/C8RY0Pw5b7LNki8C4wfqWRH71mNyRxFJWYN8mz?=
 =?iso-8859-1?Q?JnMiVMGP+Gnj7REOLggTx/pAUVqzqd8LaBff03BkQqr5npFDAybclEO8xe?=
 =?iso-8859-1?Q?XMcyXGvttBkMWBhkL9WpPFPtdNTmmzp0k80gLzgwL/EiNpi5hLtDUU4syU?=
 =?iso-8859-1?Q?LvSE6WWBWazMZHt7hLdNum6zreFZDnoLeqVkfbCjRGAXBmn1q/9dqyNRej?=
 =?iso-8859-1?Q?T2F6mFbyhpvVggdCo0soLXPthr5hQYvK+KHmQtQEplMnpHQxvY7zF/klSO?=
 =?iso-8859-1?Q?tPVpaARl7QSD8R8X4qh1+9q5fM/X7/onOftfE3a8ZlXRPl+6RluY7GWxR+?=
 =?iso-8859-1?Q?tgpAwYPrciwnXoXEbSN1XCz+UDhiIEhcJzI9oa3Zi0y1ZMR7KWpN66GUzo?=
 =?iso-8859-1?Q?mtkNmUbEMpAiwUASde/eHlvLkzOGGfGZv7p1f52W+nB3oztmxSIV4MQaJQ?=
 =?iso-8859-1?Q?3rmDLutwXnpmuUKFLKKHngqWsRHeVs6tihj/DO00EfYszkBjZN5jBgF6XU?=
 =?iso-8859-1?Q?Yz/5clmfZPJ8X+kKEHEwUsqG7T2UC5+NBS9eGc79w7tb0bvlXUXWurRiDR?=
 =?iso-8859-1?Q?Oybqetqli5/EObb244r2a9aFMcTB0l0Gkd4dMu3WwPKIc+4DHRi35lTT20?=
 =?iso-8859-1?Q?59UlzHeqoTaOZD+VCuIS0dABPveDdfAaLvrckkjevip0HRa14fWIpWk7Gf?=
 =?iso-8859-1?Q?B4yhssXwRwwdcXRsAWdBXfYveQ69jhuF4aR/0tDx44AsDr2ElgzvbOg8pp?=
 =?iso-8859-1?Q?RRWe6VynlJn6mQpLngbruonV0PKVyoPoEnXnpj65feaoglMKgj2wDDn+Z4?=
 =?iso-8859-1?Q?gWvwMxZ5R92FXTosKdXdGlrpHyAtqMNyPLpVoTuvjNrdDY9FcAk/E0eFCY?=
 =?iso-8859-1?Q?+KkCMnUSt5YyVieES4FKUoZNMM/1teC8fcaFWPwEPUklG1jDH0I1bFcClc?=
 =?iso-8859-1?Q?vYe3Jv+hZfQ8+pFWkh1yxshH7bXcZ8hQIIQNp3k/RUXehXHFbDVjo07xwI?=
 =?iso-8859-1?Q?xZdH4U+UvEloM47RxdhuAAUB4c6//Hael8XnphbafVLGsF3iFCnb9ecE4n?=
 =?iso-8859-1?Q?p+xf/ohx2DrHrNhLlNPlY+K7LyeLY+4zEnjMLFYJQ31ql8lrelEuE29jEC?=
 =?iso-8859-1?Q?dfGpMyyFN0WYmV+ERFIcNp8km6KoBSky1I?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Pj7scEaAXh1b9USKQrcmxdQtFVYtdjIoOJ6pk5ajSlJtalR6oC5B8sRahEQMgh1es51xJvxKme1ogMrxm9nTcVJw2CS/0mE/fhkUnWTqqBLJ/CchtylJZxfGwhhY55hK7gSia47vHatg9jAXChjAutdLIRKezLzAde5wKqZ55495cJDL9D5lL+4Vvy6Z0mMSLg1ldcqOrokImLRWsjGIGf9K+kPZ2Ulfz2yzncpXbNLx4M5uDampzfOI35+emdviiAh/etDp4NfZaJ+IAAo7JvHFDmHP//9U7fKruUI7YQ0nTJqWP8En0hpdBZWZh6U8fx8gKAwsTETOkF7yJ8Q182jIwjcN4MM+6Uy+upbRQF6gnU67DLxu0nS+CalVeb6s8r8MaEvt6ZgTXYOoF721TuA2A7w3/W7ls+K3KsXNoSJyw8qHHTjHsupzrnPz5f3gwjjRUUUzfZjdOHwKcDiwNwmU9BbpfojCzCAlrtVJ1PWrmPFg7Pe4BMvVeh8o19Tb/Aiq83hAwDvYyFvmJD0Raq6stRwlaCh4S0UKGs3YuYHjDIHmwoevbbN5QCXxvov5LTA5msKLOUNZmiPlxRnzuMzS0MQnrdsbkDjG4iNBm7yAKpIzbi9ZoSJASLzQtSpKG5c2qJIS3pijy6L59qeedSkSxqfCVYyZEjxgvjWab+eC9OphriEKjGMr5rYCTi9owUx0P9L0LUK7iLlQd8ft/BFX0mPrCHq72hrBsGkYHAlBAzz0r8AdXd5oazQEKqT5f2GcEI5eqTJ9iswiTXZIqapPo+Kf8kUwndShKHKKqiGQPkB/FXtb9+5B02oBWYPV1WJPeIVnKhEuK1at8cRGsA==
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5372.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cbf033b-3ea8-422a-d637-08db65a11bce
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 08:44:43.3230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6HDkLbrl+aRXCNrWL+9XxhCnnZjXwUZvxKXZaApFYOQV0RuASnmhhp6OTl1AR+u6uVKozsKelAYv6AnRUahTySazULZ4oqzEaaV394dqIfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5552
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Ross Lagerwall <ross.lagerwall@citrix.com>=0A=
> Sent: Thursday, May 25, 2023 4:32 PM=0A=
> To: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>=0A=
> Cc: Bjorn Helgaas <bhelgaas@google.com>; Kai-Heng Feng <kai.heng.feng@can=
onical.com>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; R=
oss Lagerwall <ross.lagerwall@citrix.com>=0A=
> Subject: [PATCH] PCI: Release coalesced resource =0A=
> =A0=0A=
> When contiguous windows are coalesced, the resource is invalidated and=0A=
> consequently not added to the bus. However, it remains in the resource=0A=
> hierarchy:=0A=
> =0A=
> ...=0A=
> =A0 ef2fff00-ef2fffff : 0000:00:13.2=0A=
> =A0=A0=A0 ef2fff00-ef2fffff : ehci_hcd=0A=
> 00000000-00000000 : PCI Bus 0000:00=0A=
> f0000000-f3ffffff : PCI MMCONFIG 0000 [bus 00-3f]=0A=
> =A0 f0000000-f3ffffff : Reserved=0A=
> ...=0A=
> =0A=
> In some cases (e.g. the Xen scratch region), this causes future calls to=
=0A=
> allocate_resource() to choose an inappropriate location which the caller=
=0A=
> cannot handle. Fix by releasing the resource and removing from the=0A=
> hierarchy.=0A=
> =0A=
> Fixes: 7c3855c423b1 ("PCI: Coalesce host bridge contiguous apertures")=0A=
> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>=0A=
> ---=0A=
> =A0drivers/pci/probe.c | 4 +++-=0A=
> =A01 file changed, 3 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c=0A=
> index 0b2826c4a832..00ed20ac0dd6 100644=0A=
> --- a/drivers/pci/probe.c=0A=
> +++ b/drivers/pci/probe.c=0A=
> @@ -997,8 +997,10 @@ static int pci_register_host_bridge(struct pci_host_=
bridge *bridge)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 resource_list_for_each_entry_safe(window, n, &re=
sources) {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 offset =3D window->offse=
t;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 res =3D window->res;=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!res->flags && !res->star=
t && !res->end)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!res->flags && !res->star=
t && !res->end) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 relea=
se_resource(res);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
continue;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> =A0=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 list_move_tail(&window->=
node, &bridge->windows);=0A=
> =A0=0A=
> -- =0A=
> 2.31.1=0A=
=0A=
Ping?=
