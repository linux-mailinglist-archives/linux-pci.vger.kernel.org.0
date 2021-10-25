Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC7043953D
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 13:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhJYLxl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 07:53:41 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:42369 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbhJYLxh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Oct 2021 07:53:37 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Oct 2021 07:53:36 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1635162675;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9xI6qRiq4Un/z1/Vv7HZLttkDsz8PDALHTyqsCd2u+s=;
  b=QMxvCoVDIn/Q+4MlYI83TGtSIEoVPLCA3HBKn8EJpRQBjzjDvlpT/Cnf
   JIk8TnR3KafWeuJaBZYqmoatzHcVrnX2D9/RyfxjWBNz2gH1h7hlV/MEA
   R2U4A/Oq0S3EuBC8JB4EK+B7zu98ntqpnH7IHnqJtrWEKfidF/d4YvdPG
   E=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
IronPort-SDR: 1HNTxFrdlLGQSG6nsrBlF1aub7i86xExqVG8BYSniBe6OVNnBtTZHYEiZYkaYZBGA3r2YyWyU8
 ue2nT64REwiKngHsVPdcuudHUZPV7SP30PyvaCG2LOJI6t3iFwJuLNbkVBY0AoSKkwff0TlVh+
 /eSJ5Z604tYMzARz/3fK7eH9LbLIjqYImBE+lAm16e5+RssuykiCOXnnwYcmnG3LQ0vFvkzo7f
 Why8RvUo2Rn4eCwE7FcTuhvQmrKVQf50IPPniN/H3uEFMkj6vs0srf1j8RPQhvF3nC3TnljsEG
 YShpGh6PdyqzSu60VBCcM1Zi
X-SBRS: 5.1
X-MesageID: 55528886
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:cH1aQq4ppVNFFZieuTRlsQxRtEvBchMFZxGqfqrLsTDasY5as4F+v
 jYeXjrTOq7ZMGCjc94ibo6z/EoP7ZSBnIRqSVFs+CgzHi5G8cbLO4+Ufxz6V8+wwmwvb67FA
 +E2MISowBUcFyeEzvuV3zyIQUBUjclkfJKlYAL/En03FVAMpBsJ00o5wrdh2NMw2LBVPivW0
 T/Mi5yHULOa82Yc3lI8s8pvfzs24ZweEBtB1rAPTagjUG32zhH5P7pGTU2FFFPqQ5E8IwKPb
 72rIIdVXI/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8CbP2lS2Pc0MC9qZzu1c99Zy
 Oxfv7ysQywTGbDzkb4yCTpyCzpcIvgTkFPHCSDXXc27ykTHdz3nwul0DVFwNoodkgp1KTgQr
 7pCcmlLN03dwbLtqF64YrAEasALNs7kMZlZonh95TrYEewnUdbIRKCiCdpwgWpt3JAeTai2i
 8wxVAZhNi3bOzx2BGwQN5Mag+CknyLcWmgNwL6SjfVuuDWCpOBr65DpMdzIapmSTsR9gEmVv
 CTF8n7/DxVcM8aQoRKH/WirnfTnhj7gVcQZE7jQ3vtjknWQy3YVBRlQUkG0ydGph0j7V99BJ
 kg8/is1sbN05EGtVsP6XRCzvDiDpBF0c8ZfF/0S7ACL17bO5ACYFi4IQ1ZpatUguNUnWD8C2
 VqAntevDjtq2JWZVneCrJ+Vqz2oMCQYJGNEYjULJSMH5MLurqk0gh/VSt9lHOiug7XdGTz0z
 DmDtwA9iq8VgMpN0L+0lXjNhCitvd7OVRIv4RvMXXON6Rlwb4qoIYev7DDmAe1oddjDCAPb5
 T5dxpbYvLtm4YyxeDKlQNwfFpG17d2/FyDjiARARboL7y+P5Cv2FWxP2w1WKEBsO8cCXDbmZ
 k7PpA9cjKNu0GuWgbxfON3pVZx7pUT0PZG8DKqMN4sRCnRkXFbfpHkGWKKG44z6fKHAe4kEM
 pCHbd3kM38eDal2pNZdb7ZAieF1rszSKGW6eHwa8/hF+efGDJJ2Ye1cWLdrUgzexPjcyDg5C
 /4Fa6O3J+x3CYUSmBX//48JNkwtJnMmH53woME/XrfdeVc/QDl7WqeJm+NJl2lZc0J9zLegE
 paVARcw9bYCrSefdVXiho5LMeuHsWlDQYITYnV3YAfAN4kLaoez9qYPH6bbjpF8nNGPOcVcF
 qFfE+3ZW6wnYm2ep1w1MMmsxKQ/JU/DrV/fYEKYjM0XIscIq/rhoYS/IGMCNUAmU0KKiCfJi
 +Txhl2AGcFYGVUK4QS/QKvH8m5ddEM1wYpad0DJPsNSaAPr9o1rIDb2lfg5P4cHLhCr+9dQ/
 1/+7c4wqbafrokr3sPOgKzY/Y6lH/EnRhhRHnXB7KbwPi7fpzLxzYhFWeeOXDbcSGKrp/nyO
 bQLl6nxYK8dgVJHk4tgCLI3n6gw0MTi+u1BxQN+EXSVM1nyUuF8ImOL1NVkv7FWwuMLohO/X
 0+Co4EIObiANM7/PkQWIQ4pMraK2f0Ow2GA5vUpOkTqoiRw+ePfA0lVOhCNjg1bLad0b9x5k
 btw5pZO5lXm2BQwM9uAgiRFzEi2LyQNA/c9q5UXII73kQ53mFtMVoPRV33t65aVZtQSbkRze
 m2IhLDPjqh3z1bZdyZhDmDE2OdQiMhcuB1Oy1NedV2FlsCc260y1RxVtz82Uh5U3lNM1OcqY
 jpnMEh8JKOv+TZ0hZccAzDwSl8ZXBDJqFbsz1YplXHCSxj6X2PAG2QxJOKR8R1L6GlbZDVao
 OmVxWuNvewGpy0tMv/egXJYlsE=
IronPort-HdrOrdr: A9a23:ZdN5p6nuKu/ofkq2qcj3MdPzzDPpDfPKimdD5ihNYBxZY6Wkfp
 +V8sjzhCWatN9OYh0dcLC7WJVpQRvnhPhICK0qTMqftWjdyRGVxeRZjLcKrAeQfhEWmtQtsZ
 uINpIOdOEYbmIK/PoSgjPIa+rIqePvmMvD6Ja8vhUdPT2CKZsQlDuRYjzrbHGeLzM2fKbReq
 Dsgfau8FGbCAsqh4mAdzM4dtmGg+eOuIPtYBYACRJiwA6SjQmw4Lq/NxSDxB8RXx5G3L9nqA
 H+4kDEz5Tml8v+5g7X1mfV4ZgTsNz9yuFbDMjJrsQOMD3jhiuheYwkcbyfuzIepv2p9T8R4Z
 TxiiZlG/42x2Laf2mzrxeo8w780Aw243un8lOciWuLm72xeBsKT+56wa5JeBrQ7EQt+Ptm1r
 hQ4m6fv51LSTvdgSXU/bHzJlBXv3vxhUBnvf8YjnRZX4dbQqRWt5Yj8ERcF4pFND7m6bogDP
 JlAKjnlbhrmGuhHjPkV1RUsZ6RtixZJGbCfqFCgL3b79FupgE486NCr/Zv2kvp9/oGOu95Dq
 r/Q+NVfYp1P70rhJRGdZA8qPuMex/wqC33QRevyHTcZek60iH22tXKCItc3pDfRHVP9up1pK
 j8
X-IronPort-AV: E=Sophos;i="5.87,180,1631592000"; 
   d="scan'208";a="55528886"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5HafTh1R15TvSoOC4LwpQIFMb0hbY8AowQa1iyOKLkMZp3GvtbjwZPxPJfbaXDDL8TUTksak7wq4l/ziJLlkXmAEu9ShWc8J/W9Oc8HWHGrMFAJf8q11NAKv5wQigSKEo2/cP9TzkQ4kqF+yYGljWSh0KJbbUpYGKszUYNc37o8tQZisvpYqDwbNbS2xJ98UK1dQVaaIkNNKhAGqAbKsCXJu+mBBHhGK/qd8kLm+bvt0d8nDUkfZRXRWl6N4IwFpnKWD8/wR0TgGlg46pefwD8MwYXqsc50TGv70Ihtl791gYPgQqhTD4ee7dJQZcH8Pyy8rHbjIzRFvDEMl3KrHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FpfaW3BRyX1N9WZkadSTTzAgNcRaEKnF+r1qoySrlE=;
 b=AvpUWnQsSfNnRvaU99jyGBhnEWgvCdjcEBmVI15zDXdTZkmkupEMBpCsF/TC5o7KYWEjlXo5uvpHlML73YTjD3780eVojgIArqb4D8mv1/0VfppofBjjmUSfyYckFf2Cx+sa+ReDZOiWhAxaqClaM9D40qXffA9DjSvm3vyd88CEz+m4L2dYJeTjzFeqPFgAUoKcpOmpYhBWQxh0AZ19RORtNb7cMDsfSfo+1O88hkBSYWZ8dA645/GdstaDcUPbI8i+eXJLvU+a+rZ5A0S8eLiqj0TKyAiIoBKwmz+jiCKNpAvxNiOGXrk7zW5SjpVpe2BLQtAr9VWDTESvnAE2lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FpfaW3BRyX1N9WZkadSTTzAgNcRaEKnF+r1qoySrlE=;
 b=vYSgmG+S/SbqpmPymTDMe7JEOL7oO4z6NW56wrCTShR5WdSUrn6Qxqy01usBDF5YETjn/Jb7Ah9JmGCuy5eRcnv6Fpr6wLS/EGi01G5PMlOvr056I97aItzF2SfD5QcZV7hBHbXTOJ+FONV0DgkBpjtKaei9lTWj7CMEbsdJXU8=
Date:   Mon, 25 Oct 2021 13:43:55 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     David Woodhouse <dwmw2@infradead.org>
CC:     Jason Andryuk <jandryuk@gmail.com>, <josef@oderland.se>,
        <boris.ostrovsky@oracle.com>, <helgaas@kernel.org>,
        <jgross@suse.com>, <linux-pci@vger.kernel.org>, <maz@kernel.org>,
        <tglx@linutronix.de>, <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] PCI/MSI: Fix masking MSI/MSI-X on Xen PV
Message-ID: <YXaYe/RF6NWFKxGj@MacBook-Air-de-Roger.local>
References: <90277228-cf14-0cfa-c95e-d42e7d533353@oderland.se>
 <20211025012503.33172-1-jandryuk@gmail.com>
 <eb38c1d2707d03bf675d7b15f014cbe741de0998.camel@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eb38c1d2707d03bf675d7b15f014cbe741de0998.camel@infradead.org>
X-ClientProxiedBy: MR2P264CA0148.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:1::11) To DS7PR03MB5608.namprd03.prod.outlook.com
 (2603:10b6:5:2c9::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 386bb8a2-1487-4169-addb-08d997acbd70
X-MS-TrafficTypeDiagnostic: DM4PR03MB5997:
X-Microsoft-Antispam-PRVS: <DM4PR03MB5997A11F8D65EB5A5BD37AAE8F839@DM4PR03MB5997.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fCTLK71ASZFRfJO4AmtSEEe5r3u8L4Z1Z7fRD55qd9ZpoH+Xk8cYzV1Poqdu9ML00VTiNa/7qXlZHT/Vo7hLhhhvi7w3pEAjoi9VugOgzidV7hwDnojVQgciT1sGzgivReUe7wymBI4Npp4LFl9lfBip4Tq8TbS2CidgQDxjDO5LVGQQnXfUWWzUH5Zl5ySpgSLSE5z00ge6NulsqBAi2nOWZrIABt49SJVk11MC2ziXm/SV4JWtDZzh9FrQPdsNSNA+iHmYtF9A5vVuDZ8IlewOGVRx58yPBPA0ce19gA2VPFbwJDhpqXqmyhGQMWTsA/Y598VfBCdLMS92BTX2u0cu2+qHD4zG3F9bV3Fb46mZ/jb7Ld0nEDMtpozq2h6dYBa9MpGV96goLHF/vbmlRM0Es5p6zLjm/NNkwxFtJpXm8RCowEpF++puR3qyDrWzmTxw5geJz1f53N+fVI6zhaQBsB5qF3YtVnt+x9f5zijwBbBhUL7p5U/ujuuMomljtmhhWfE19albpTAJKLogjREmLD6q/i4d7jS1tHXEvRRmIpXu9zF7r19GW5BAsPGhpeQh5W1+o5Iv3Un+wmGDfk+lNjbMTs0KTNasLdvoSLg72r9S5BeO15ppeUkKbuTuBfnFIduvG5syBEdueW9MCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR03MB5608.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(66946007)(66476007)(5660300002)(2906002)(86362001)(508600001)(26005)(186003)(85182001)(4326008)(956004)(7416002)(38100700002)(316002)(4001150100001)(6496006)(9686003)(8676002)(82960400001)(8936002)(6666004)(6916009)(83380400001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y25Oak1ndUIvWW5oeGwyYkppR1lES1NEYTZKTXYvTkdvWm1NbVNMTys3MWFG?=
 =?utf-8?B?RGw5YTJNVnE2UTI0V3h4Sk95M3E5YkJtY0ZIWDA1a0FEUnF6cEtpamZhVG1w?=
 =?utf-8?B?aUZrVFhWSWtCUWQ3T3hZd1ZYbm83TDBob0Mxc0VwRnMxaWxwSC95Z1grUzZW?=
 =?utf-8?B?VFRpampEc2U3eHZ4aHVmK2NCUmY2emJKMXF4c2gwOEJDSit2aXZLN0dLZ1I4?=
 =?utf-8?B?MDBMY0hDTnVCQk56TDIrYjUwdy85K0piRGljVVpjbDE2WDhVcGxreCtIc3Rt?=
 =?utf-8?B?cVFvczB5cmdFUm9HanFBRHBnd3NJZmJUSHlrQkZkMkRvWllpdUxxZzAyS3RH?=
 =?utf-8?B?T0p4TmpsYWtJVno2TjhrSW5JSmhrRXRsck0zUjkzZUdUL1V4T2o0SDgySU55?=
 =?utf-8?B?T2RWNHk5WTdSN1VVelhVSlFwdXczMU41UGprcmZNcDF6T0VxcFBCNUNIMGhu?=
 =?utf-8?B?M2pwSzR4S1NINzhpZGRjcDhHRnFxWUNwdnYzZ0IzWlhHM0gvYzMzUE85Tnp6?=
 =?utf-8?B?RVN5WENsbit3WjNLWW5lcGltUFdLaUFBN1lBOHA1ekJoVFJHU05GaFFBNTln?=
 =?utf-8?B?Vy96SUxycWJYcXIwSGdDWVdXUVpPT0tGdENaV3ZTOFlmamNEWGJTUzhyYThB?=
 =?utf-8?B?Vk9IanB5L1krTkh5Wk11U2d3c29CS3owcmRYMFgzbTc2Q1R4ZTZzeDhYZy9l?=
 =?utf-8?B?QzBEb3FXTHJpNVhOUDJvelB0N2Y1V2dSYzJmSnJ0SVJWZG5MMFE1WFk1NjZw?=
 =?utf-8?B?ZG9rVThDL0pIcC9vcVp4NUNOSGZPdXFXV0tEUnZYb0o2OWZWOE80ajczUzFT?=
 =?utf-8?B?ME1ZSkJydVlScmxpWERuaC8ramIzWnhadWhqSnRzZm0vOEkwNU9ENTVFUTZy?=
 =?utf-8?B?cWJEVkVVaUY0V3FiRXhqbXBIMTVKL3owWHlVUWlXdG9tTXpBUlUreUFpaHNG?=
 =?utf-8?B?ME1JRTFtVlZxMDlsT0hyM04rTmZCSmNxdVY3MUh3NHBjRHhJVXVLYmx0cU9Q?=
 =?utf-8?B?R2xrdzBKUCtFR2RaVzY0Q0VPdmlxUDFVQVN1dkFUZWd3OW1TY0dJRW9BbnU0?=
 =?utf-8?B?TExzSXduTEZQWFYrS3BQRWxielFPSER3dEx6MUdSMXE2ajlPbkhMTGF3RENL?=
 =?utf-8?B?MFl4Z05mZ0VZNmt0UTN6bkdacUtodVl6Y3NPSzVJaFMzMXFDTzNyQ3RTdWRY?=
 =?utf-8?B?TjB2RlJzMnVVUEJIUEMvY1ArcjFVWTVkTWlsczVTQWsrcVlaNVAvdzZUMHYy?=
 =?utf-8?B?K0o1UlordnF0R1JOSXFGLzg3N2Fnbnk0b3FkWXFQSHA1M2FPcjRnaE5mY29j?=
 =?utf-8?B?Y1FzUGxKU0V5VmRQQXNvQkw2SnkwcFBrODNPWnU1aFRmQ3BQOXI2Z3ZwYTYx?=
 =?utf-8?B?V0x5M0VxT3BRY0V6RE11TTVYdmlsbCtaMEFzY1Yza2ZldStBei92RFdUUVN2?=
 =?utf-8?B?RjRINnUxRDdoajZWZWxIY3c3VzJDeWlKa0NOd1dRaFlmeEFZTCtsMEtKa2t6?=
 =?utf-8?B?UDUyK2hCejd1NnFoc0FLemhSQVQ2L0ZlNFM0MERZNFgycHJQTElSSzVtTTdn?=
 =?utf-8?B?RUhseStyR2h1ZUFnbVhmNDkxbE9lRXNWU3J5YmViODF2cy96VmVIVlpJeUVM?=
 =?utf-8?B?MktFNEwxZGdPUUg4MVRHMnhnWmRGV1VtQXp1NGJESzNnSExvUzFDQ0kzY0pp?=
 =?utf-8?B?aTBpdWpvbDZEUWRRdXhxSEdHV25IR09XMko1d1V3YUFIbGNGSXpScU0zVGhQ?=
 =?utf-8?B?SmN1K1pSdGdMWnJEOHRSWkVCZ2U1K05jdElOSnJIbjY1WVhaTUp3LzRzYmFn?=
 =?utf-8?B?VmYvUDhJS0liRUNwMjVjc1VvdkNxekRmcVF3UWV4bzFDNzBDbDRYVFVMcVg4?=
 =?utf-8?B?ZUl2cEJ0ZXdHbitIUnFSbmZaWU5Wbkk0Q2ZzMnZNeTFQNzdoNjZ5eXZWcys4?=
 =?utf-8?B?ZDRDYXMwVFhFaTVKRjR6N0xCT3QzanEwdjdadTVaNUt4Z1ZvTHFlTW05L0wy?=
 =?utf-8?B?aGZSYjBIMTU4c1lrUmFySmM5LzhQOUphZmc4Ly8xNnduSmFON1dFYzh3L1R5?=
 =?utf-8?B?UHpUcXl1ZGwra2p1a0pEdWFBZkt2QlIvV0JYZDBCeEdyYVZLNFJxY25Hc3h4?=
 =?utf-8?B?OXROK0E3azIvS1o4cnJiMkF1aDFHajJEZEkxSmFzd0hDRlpNbG1vK3ZsV1d1?=
 =?utf-8?Q?7lmn9EEUNgSYMjsUvoB2SIk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 386bb8a2-1487-4169-addb-08d997acbd70
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5608.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 11:44:02.0552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFWGYLJj5W9bJgP72YE9ZvUt7pWKmFMTsgrFapJ6bH2Q+OdA4EwUWmH2ay6bR1ScOfA5BTMcB4Jcb65YEdZrWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB5997
X-OriginatorOrg: citrix.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 25, 2021 at 08:44:52AM +0100, David Woodhouse wrote:
> On Sun, 2021-10-24 at 21:25 -0400, Jason Andryuk wrote:
> > commit fcacdfbef5a1 ("PCI/MSI: Provide a new set of mask and unmask
> > functions") introduce functions pci_msi_update_mask() and
> > pci_msix_write_vector_ctrl() that is missing checks for
> > pci_msi_ignore_mask that exists in commit 446a98b19fd6 ("PCI/MSI: Use
> > new mask/unmask functions").  The checks are in place at the high level
> > __pci_msi_mask_desc()/__pci_msi_unmask_desc(), but some functions call
> > directly to the helpers.
> > 
> > Push the pci_msi_ignore_mask check down to the functions that make
> > the actual writes.  This keeps the logic local to the writes that need
> > to be bypassed.
> > 
> > With Xen PV, the hypervisor is responsible for masking and unmasking the
> > interrupts, which pci_msi_ignore_mask is used to indicate.
> 
> This isn't just for Xen PV; Xen HVM guests let Xen unmask the MSI for
> them too.

It's kind of optional for HVM guests, as it depends on
XENFEAT_hvm_pirqs, which sadly gets unconditionally set for HVM
guests, thus dropping any benefits from having hardware assisted APIC
virtualization or posted interrupts support.

AFAICT pci_msi_ignore_mask is not (correctly) set for HVM guest when
MSI interrupts are routed over event channels.

Regards, Roger.
