Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46644439841
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 16:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhJYOPI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 10:15:08 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:29973 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhJYOPH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Oct 2021 10:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1635171165;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=EASz5039FEq4/EXI3gKv09M6id3KXQI9eF4+tgh3qxk=;
  b=ZmhU60eIDpRY1uAqcI7pps5SkKu76sZJL0rnLCXR8qR3KvltuPLtHJcM
   OBYqmLlx/Z3SVnI0KYiHGfwpOhFU6xZR599bNfWCU6oejdsKUuVm23aW4
   oJlYBPoTtR8BIz1JyhxpDfjR/laC0ZR/9yCq7siBldf5KmGv7YAKx7xEq
   4=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
IronPort-SDR: raXoSIRjazv7HnrKmFEveVUWdjK8sQOxaA52f7fd4U1luQwWrZ9BaV8LAQeVSe/G+fEIeYjzNg
 wMX/zFFJypds0rZgqoRadcEF5cM25/ul3+HR5xMmwYEy/vxQBvV6oJzT+3A1dVQb6hEM9l/Xxe
 LHdNdRldPjO+2B6bP4faEvknX1XiXFdOL03fPDmLp2ceH5xkXuYNoNhdNfuzyorqgsXypCavod
 Ml+BebBk8gppIGFBbeSyqhIjpKbn0tYim+lTUo6A4UP6QX4jw9uOXdZCR/3T1VBLz1vbbVhBvI
 q0hxxX/KydOjAWeOy17Zaz8q
X-SBRS: 5.1
X-MesageID: 55544333
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:1Sb1FKPwyzpbSLnvrR3WkcFynXyQoLVcMsEvi/4bfWQNrUpx0WAAz
 TMWUG3SP6zbZGXzeN8ibY3j/UlUvJfRx4A1TQto+SlhQUwRpJueD7x1DKtR0wB+jCHnZBg6h
 ynLQoCYdKjYdpJYz/uUGuCJQUNUjMlkfZKhTr6bUsxNbVU8En540Ug+w7dRbrNA2rBVPSvc4
 bsenOWHULOV82Yc3rU8sv/rRLtH5ZweiRtA1rAMTakjUGz2zhH5OKk3N6CpR0YUd6EPdgKMq
 0Qv+5nilo/R109F5tpICd8XeGVSKlLZFVDmZna7x8FOK/WNz8A/+v9TCRYSVatYozqjhI177
 /9yj5+baz4XIbeVurUkajANRkmSPYUekFPGCX22sMjVxEzaaXr8hf5pCSnaP6VBpLwxWzsXs
 6VFdnZdNXhvhMrvqF6/YvNrick5atHiIasUu216zCGfBvEjKXzGa/iXuIMEh2xr7ixINc37a
 dIoeTNKUDTnczdIOQcoOqk8tuj90xETdBUH8QnI9MLb+VP7yA13zaioKNHUUsKFSN8TnUuCo
 G/CuWPjDXkyNtOFziGe2mmxneKJliT+MKoXHa+Q9fNwhlCXgGsJB3U+RVa95PW0lEO6c9ZeM
 FAPvDojq7Ao806mRcW7WAe3yFaYsRoMc95RFfAm8gaLy7qS7wvxLmoNSDJbecElnMAzTD0uk
 FSOmrvBCSNqr+e9SHST7L6YoDq+fy8PIgcqZygfQAUt5NXuuoU6iB6JVdsLOK64itL8ECrYw
 D2QqiU6wbIJgqYj3aKh/EuBhCmwvJ/XVQ0kzgLNV2mh40VyY4vNWmCzwQGFt7Aadt/fFwTf+
 ihf8ySD0AwQJZ6nj3GHZ88yJrKCxc+7LyeFow9WJrB0olxB5EWfVYxX5Th/ImJgPcAFZSLlb
 SfvhO9B2HNAFCD1NfEvMupdH+xvlPK6TY20CZg4e/IXOsApHDJr6h2CcqJ5M4rFq0Mrjb0kc
 amSdcKhHB724ow2kWLoGY/xPVItrx3SJF8/p7iml3xLMpLEPRZ5rIvp13PVNogEAFus+lm9z
 jqmH5LiJ+9jeOP/eDLL1oUYMEoHK3M2bbiv9ZcKL7bbeFs+QDtxYxM0/V/HU9Y190iyvryQl
 kxRp2cCkAav7ZE5AVzSApycVF8fdckm9i9qVcDdFV2px2Iice6SAFQ3LPMKkU0c3LU7l5ZcF
 qBdE+3ZW6gnYmmXqlw1MMimxKQ/JUvDuO57F3f8CNTJV8U7HFKhFx6NVlaHyRTi+QLu5Jtg+
 OX7jV2KKXfBLiw7ZPvrhDuU5wrZlVAWmf5oXluOJd9WeU7295NtJTC3hfgyS/zg4z2YrtdD/
 wrJUxoeu8fXpIo5rIvAiaye9t/7GOpiBEtKWWLc6O/uZyXd+2Oix65GUfqJIm+BBD+lpv36a
 LUH1ez4Pd0GgE1O79h2HYF0wP9s/NDovbJbkFhpRS2Zc1SxB7p8CXCaxs0T5LZVz7pUtFLuC
 EKC89VXI5uTP8bhHAJDLQYpdL3bh/oVhiPT/bI+J0CjvH17+7+OUENzORiQiXMCcOspYd19m
 ep44ZwY8Q2yjBYuI+2qtCEM+jTeNGEEXoUmqooeXN3hhD00xwwQepfbECL3vs2CMo0eLkkwL
 zaIr6PenLAAlFHaen8+GHWRj+pQgZMC5EJDwFMYfgnbn9PEgrk83QFL8CRxRQNQl00V3+V2M
 2ltFkt0OaTRoGs42JkdBzihS1NbGRmU2k3t0F9YxmTWQn6hWnHJMGBga/2G+1oU8j4EczVWl
 F1CJL0Jjdo+kBnN4xYP
IronPort-HdrOrdr: A9a23:tP8i7ampb189e0cWhTCBw8wR1FvpDfOwimdD5ihNYBxZY6Wkfp
 +V8sjzhCWatN9OYh0dcLC7WJVpQRvnhPhICK0qTMqftW7dyReVxeBZnPHfKljbehEWmdQtsJ
 uIH5IObOEYSGIK8voSgzPIY+rIouP3iJxA7N22pxwGIHAIGsMQnDuRSDzraXGeLDM2dKbRf6
 Dsn/avyQDQHkj+Oa+Adwc4tqX41pD2vaOjRSRDKw8s6QGIgz/twLnmEyKA1hNbdz9U278t/U
 XMjgS8v8yYwr6G4y6Z81WWw4VdmdPnxNcGLMuQivINIjGprgqzfoxuV5CLoThwiuCy71QBls
 XKvn4bTohOwkKUWlvwjQrm2gHm3jprw3j+yWWAiX+mmsD9TCJSMbsIuatpNj/ir2YwttB116
 xGm0iDsYBMMB/GlCPho/DVShBDjCOP0DofuN9Wq0YafZoVabdXo4Ba1lhSCo08ECXz751iOP
 VyDfvb+O1dfTqhHjHkV1FUsZ6Rt0kIb1K7qhBogL3Q79EWpgE286Ig/r1dop9an6hNDKWt5I
 z/Q+1Vff91P4krhJlGdZI8qP2MexrwqCL3QRCvyGvcZdU60lL22tXKCeYOlauXkKJh9upEpH
 2GaiIAiVIP
X-IronPort-AV: E=Sophos;i="5.87,180,1631592000"; 
   d="scan'208";a="55544333"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUPv6nHF07c/FoIRpmjqLN4Lb5FUIvD+vZHi9oiwanaJL0Klu8o569jggpZYzdHYHrRerJBIg5kz511hMuGw/bloE38XXycDuM1lRYtcmCa0VbO8mkDVuGYLL+xMcYycZ4uPi1hu78PWAduzFYkMyAY3rs0QnHSsUoYGeRoE0l0iMUti+aYRtc8HaoW/BgCff53oOfZ7wh6TPeDL447XQvhOrE2mAK5xpGK69gwxCx94FoEVxFMcnUPuO/hadz1w0ekpOVFw9q+XkWyObaBs2wjVE89jHOrOTfZN9fPnplCSGu44HiZdhu45p1AeLNmTgcu3EA6/uKHrYUgAm3X+Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Qb7MN/jnEZwBzzlZMq5VTbnICJ88x13Shn0e0Jmuto=;
 b=IAP3IVarYuEVv5TUnXD+sgGgBTfMum3ARH2TNTtywfkXix4/VhsVx6l+zLga2ypMlC5csJKjQWEBD0oqQbTjpCwl/KpBkSfYPe9kzetDNv1BCU5GCOUXLWT4xvnmGOa79CO16YKnkc9A5d3IYRS9evq2wQM/dz/QASi/mNtPEB9LPWKYqmMArmTJO37PzXRV2IjB9rrVUCZf2cTRGdmbqXqOFIUM/FBVUS18hYgu9sYTTNP30jWCg8a0xKSNBlxxVlc1fUX3M0mbqjwjM8vJGX4QP66ZFxnEZaffghgATNQjtk8CTG2K2+KrjF5sMRStIbOcowGRYuNH/75BL799iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Qb7MN/jnEZwBzzlZMq5VTbnICJ88x13Shn0e0Jmuto=;
 b=kPWxqBXOWQP7dTuTnDUBYL3I4LYxe0ixO9MKV92NmKUc4Zn8TQrcm5OEGeVqp0/aFAWnYdVJi0403eK0EiT5phWVo+04FpDtZ6YuICSzbxcHselQFFGIcruOmaF0Sg1CikYRx/ImNq1TQrmMY+6qAloylXRD5EDfwqgNabn5tfc=
Date:   Mon, 25 Oct 2021 16:12:34 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     David Woodhouse <dwmw2@infradead.org>
CC:     Jason Andryuk <jandryuk@gmail.com>, <josef@oderland.se>,
        <boris.ostrovsky@oracle.com>, <helgaas@kernel.org>,
        <jgross@suse.com>, <linux-pci@vger.kernel.org>, <maz@kernel.org>,
        <tglx@linutronix.de>, <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] PCI/MSI: Fix masking MSI/MSI-X on Xen PV
Message-ID: <YXa7UtYyX7y+cCwU@MacBook-Air-de-Roger.local>
References: <90277228-cf14-0cfa-c95e-d42e7d533353@oderland.se>
 <20211025012503.33172-1-jandryuk@gmail.com>
 <eb38c1d2707d03bf675d7b15f014cbe741de0998.camel@infradead.org>
 <YXaYe/RF6NWFKxGj@MacBook-Air-de-Roger.local>
 <72d763d055929b8c81f0c8deab14b33bd252c946.camel@infradead.org>
 <YXaqENqdjx0lJ+Fx@MacBook-Air-de-Roger.local>
 <acaca10c50155b75c82c6370236231856b30ade4.camel@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acaca10c50155b75c82c6370236231856b30ade4.camel@infradead.org>
X-ClientProxiedBy: MR1P264CA0045.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::8) To DS7PR03MB5608.namprd03.prod.outlook.com
 (2603:10b6:5:2c9::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e49d1d77-392e-493b-e6a4-08d997c18144
X-MS-TrafficTypeDiagnostic: DM6PR03MB3579:
X-Microsoft-Antispam-PRVS: <DM6PR03MB3579BD22CCA0ED4057B2BD918F839@DM6PR03MB3579.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 60tQ/25SouDiWF0506mge1Bz42nFYMKiD6IOhR7Du/g5PkfmFRMpzRO5+8YiczeIlmEwK7OTEN9eafDQ4DIxlck+yGlY9zn6URG0qP11i5v5SNR1x//wQvux0DlqchJJhMU+l1N+TY49Z0aMhcbPj3rBu3vMQv4opT2jaUEx4VTe6qQRvGIhgtCkrzNlvY4LrsbBNxlrXbtsryS978xw68O5mynyPZZ9omsYrXAJ4BRr/5Pk2IexE5r5awtUb4c38Qj9FzMYceo9jhkfRLvce2njCNvFWGJOtxjy18MxgDBOajWtxwu29yRW39P3m+HudHW7rF4I+0BBi+MHip7xvMQ6c/GSRfz8hZ0TV/FtvKh1XxayWhma2mIMWsjztNQ/mlPN6N3B2+ummz4/X5OPEYW0QQUTQlLbhrEhky6WkZ3iIBeilcq4YTbHxjcYTMm/ekc273F8Dc0qozuKdiHF/gLCFbZSVqi+i29h6gtSqrBkZ8zeGuUZ+zo1467/yHVldpNgOed9qDVFfLY/GIuegxI8vVHZls/ofj+YRgDjLi2kwWHvzFynA7OQzhGbH6X9RW8dFQoSyJrKK4AgbR6Hk0WyJHZ1nioobok3/KkhMbR9DeyTRhnftWJMNeyrcgWKBNCzozxmeEKWKjGopFyCwUhbmZa/GdljcsXD2NnjLNfK7KUhGEXFwv+3vefDJmHRNAxAm3Fy2M6qCqzhQ9L0Jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR03MB5608.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(8936002)(6666004)(66556008)(26005)(316002)(82960400001)(66946007)(7416002)(38100700002)(956004)(8676002)(4001150100001)(66476007)(186003)(5660300002)(6486002)(6496006)(9686003)(85182001)(4326008)(508600001)(86362001)(2906002)(6916009)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDUxY2JBTTJIcFExZ05wWFJoVUE4dkNGbmoyazl0ekFtWGp0bVNDQlNKRWNY?=
 =?utf-8?B?L04vNXc0bVd1bEhYKytGVTRIeXlyMkFsQ3AxdXRkczVpQWUxWldPUWt4cWQ5?=
 =?utf-8?B?RC9aRUFKbXZVa3FxVkhKaGsrb2ZDdzhwUzRNSkZ4eWxjNzZvVjFraGpWVUxj?=
 =?utf-8?B?aHpHWmlxNU5JVlN6c09vcHUyVm5keWFnZVJPSTM4clNUanNJamQrVkJZaHov?=
 =?utf-8?B?clVQRjJFeXpQaHQvblpoYkpJOS9EdW1XbTZHTG83ZkI2Wm05anNTYlRIeHpW?=
 =?utf-8?B?U3lvOHpVRmh3bWtnNTF3K2xBcTdvNm5tRFE4Wmt2TElOcGkwakxEZ0d6SzRu?=
 =?utf-8?B?RklucTZLbWFLbVhIRFhhMUpxVU50cVhIZGgvV1cyRklVL3N2aGpLOWUwYWRh?=
 =?utf-8?B?eXJPSTZjZksrVnc0MWZOQVdGODk3b3dkQnBUUTUrcVBLTXhmelhyT3lrdGZz?=
 =?utf-8?B?R1FzQ0JKWnB1SUJWMEo2SHhBa1BHTTBZQS9BajNmZXo2VVF2WEFMVG9TUjk4?=
 =?utf-8?B?Z0s0OHowUEZaZXFNOWJTcnA4MHRkYUlzejNhbTRua2c3cXBIZUZFWGpnQlpS?=
 =?utf-8?B?QmJES3NVMllOYlFmSCtkTXpnSEs4ekhyNnF0RU1DaWc0WEdOUWFidGtsTXh2?=
 =?utf-8?B?SnZWY0xKM2dFZlJFUVI1SGk3WW03VXRyNlZuVXNybXFnT1k2c1hlS25jcVQz?=
 =?utf-8?B?ZXNpS3MxK3VMZ2dlS3p0bnpLQmVKc1QvY3JyRGR6b2JWdzJkQnYxSk9GaWxl?=
 =?utf-8?B?R1JFbUxGWjhXTXhNRzNDK1BZZUxVT2ZnWnQwMklyZi8vNmVaRnNKRzNzUXB3?=
 =?utf-8?B?U2NhcGh5cTBRN2dxY1JFT1hlTDhJVUxDTTNiakhOMUppYkZ5RkhNT1JnSlE5?=
 =?utf-8?B?aFZZek1XdGxnNWF1SzZwb0FDbm9OeXVWWG5wdFptYTlKenFjQzJiUWExdWRZ?=
 =?utf-8?B?V1p4a2w5YjlvR2x3TjV0cTIveUh1b0txNllLbFNVakpHNTc3Q2N1b2RqVi83?=
 =?utf-8?B?TDhJRU5mUi8zR1BkWGFRWW9KeUVQdTFrc3RYZ2RjYzJaWVRYZ3A1Nkhwdmxv?=
 =?utf-8?B?cnowQUIxUE14am92VE5nUFBmUTZwaCtaM0xPQXBnU3BWdklaVnZCbWJSN2xv?=
 =?utf-8?B?Y3NzR25Sd0ZCS25MQm1wUVlMNWIzaldIZ3BWM3hLR3JMcTQ0ODZPaGJxQXlv?=
 =?utf-8?B?b2tsN09uZDBwREt6VnlGTWVYa0UwdGRYVnV4Yjg0U25WUGRuN0J2MFl1ZHVr?=
 =?utf-8?B?VmtTWGs5MDhKY2hVUE1qZklnSXplTVRLalRDMXlaNE94YWdBak8wM3c5Vlo0?=
 =?utf-8?B?eHQrdFJWcWMycUYwN2Ryc3JrT1cxUTZQMzNvOXRSdHFSYnV5TDJZY3ZWblhu?=
 =?utf-8?B?UlNtR3gzWUhVMys5eWl5RFo2cTJxMFBVYjJtclZRQ3pFblJKY2pQK1liNk8z?=
 =?utf-8?B?N1lFVjRrK29UR0liRTFvRkkzZGRxb0xqSXhsR211U2lsbE91L2xVS3N6dXRk?=
 =?utf-8?B?TlFrdWJSam1PdE1jSnFSakFManNlMktyVlBzK0JTUFRJMmZPUFAwN1pDaDR6?=
 =?utf-8?B?LzVhc3M0ZEh6LzZxQVRZSVBNTXJqYnZpbkk3VlhJcnppcnBmTnVpOWVXYXgz?=
 =?utf-8?B?YTZ2Q1JiRFJFTXNhWFNFNzBoenVOSHBoNHpsY1IrZ00wd09Pa3ZuajY4cXZB?=
 =?utf-8?B?d2dFQkVjRFhscGpxbzR3cmYyQ1dWRVMrTEFBV3lhaXlFOTM4emdhK1AxeFBQ?=
 =?utf-8?B?cDIzdDRIWkNhVWdUVmN3UVRBeGFsTndkVGVVLzNtRnozbmNpTTVFdHl0L1dx?=
 =?utf-8?B?ejRLWHhSanN0V1BodGF1K3lDaXhnT2JNVnZqUlE0eHJReWRzbmFXTExROG5V?=
 =?utf-8?B?ME5TUUo2QW9qMmVhUjhQbnVpbGt4RWRZK1JyWS9RT254VE9kRTRISE9BZVls?=
 =?utf-8?B?ZHk0VVF4Z1FOcGY4NkpHSzl0SHEwMW1QL0pZVEY3aFg5TUEybHNSUWthMkdY?=
 =?utf-8?B?MXNxMXNkVWtCVmgvMkk5a2xiNkYvcGJBRGwrY0duYUh6aStHenpVay9XQzh3?=
 =?utf-8?B?eFhmSHRhTlhrOXBqOFJFWThWcTZZd2xRWi9tSHFHcG4zSFBMZFNCUDBZY09B?=
 =?utf-8?B?ODFTdWJXVXJxY0pUaTRuVm11VStWQmJ6ZittNEt3dHo4bHUvV3E0QmlLYzR4?=
 =?utf-8?Q?5BIxDNRHrWJCJIOfRKzohMM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e49d1d77-392e-493b-e6a4-08d997c18144
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5608.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 14:12:40.4806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iv+OHK0RYpZw5Lc2jBeXn4oJJ0YjUaGmbA/akZTpJwJpURxVl4puc+Ci/wREUfHvFOyS5EdhNQk2v6BjexHpBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3579
X-OriginatorOrg: citrix.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 25, 2021 at 02:02:38PM +0100, David Woodhouse wrote:
> On Mon, 2021-10-25 at 14:58 +0200, Roger Pau Monné wrote:
> > On Mon, Oct 25, 2021 at 12:53:31PM +0100, David Woodhouse wrote:
> > > On Mon, 2021-10-25 at 13:43 +0200, Roger Pau Monné wrote:
> > > > It's kind of optional for HVM guests, as it depends on
> > > > XENFEAT_hvm_pirqs, which sadly gets unconditionally set for HVM
> > > > guests, thus dropping any benefits from having hardware assisted APIC
> > > > virtualization or posted interrupts support.
> > > 
> > > Indeed. After implementing PIRQ support for Xen guests running under
> > > KVM, I spent a "happy" couple of days swearing at it because it
> > > actually *worked* if something would just *unmask* the f***ing MSI, but
> > > the guest inexplicably (to me) didn't do that.
> > > 
> > > Took me a while to work out that Xen itself is *snooping* on the MSI
> > > table writes even while they are *masked*, to capture the magic MSI
> > > message (with vector==0) which means it's actually a PIRQ# in the
> > > destination ID bits, and then magically unmask the MSI when the guest
> > > binds that PIRQ to an event channel.
> > > 
> > > I did not enjoy implementing that part.
> > 
> > I can see that. It's even better because none of this is actually
> > documented.
> 
> Indeed. I still haven't worked out if/how Xen actually *masks* the
> corresponding MSI-X again. It can't do so when the evtchn is masked,
> since that's just a bit in the shinfo page. So while the evtchn is
> masked, the MSI can still be screaming into the void?

I think so, it's quite weird because as a side effect of this mangling
Xen is transforming an edge triggered interrupt to a level triggered
one, as masked event channels belonging to MSI vectors will get set to
pending.

So it's not entirely screaming into the void because it will get
(wrongly) set as pending when masked.

> Perhaps it does so when the PIRQ is unbound from the evtchn?
> 
> > > FWIW the *guest* could potentlaly be smarter here and elect not to use
> > > PIRQs when hardware assisted vAPIC is present. Aren't there some bits
> > > in the CPUID that Xen advertises, which indicate that? 
> > 
> > Yes, it's in leaf 0x40000x04. FWIW, I would also be fine with removing
> > XENFEAT_hvm_pirqs, as I don't think diverging from the hardware
> > specifications gives us much benefit. We avoid a couple of vm exits
> > for sure, but the cost of having all those modifications in guest
> > OSes is not worth it.
> 
> These days with posted interrupts, it doesn't even save us any vmexits;
> it's all that additional guest complexity just to give us *more*
> vmexits than we would have had :)

Oh indeed. I was thinking about hardware without APIC hw
virtualization or posted interrupts.

Roger.
