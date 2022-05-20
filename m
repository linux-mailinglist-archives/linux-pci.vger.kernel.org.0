Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511F552EF79
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 17:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243998AbiETPnE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 11:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345047AbiETPnD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 11:43:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4760E57100;
        Fri, 20 May 2022 08:43:02 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24KFXR64022587;
        Fri, 20 May 2022 15:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ltoq1olNR8WJYwxw4Bm2LDNO1mEZyrvJflXQNQaCZjM=;
 b=M9Rfi0p8njY3uH9Z2+uQp88gbOpM8Rrl8gs9Ywk6yM+3CpA75Ji6DolFJkecr6tLhYFw
 oRUdUrQrUSKAAdNSqZI1mOCVDSplpztmjrWCrStnHMZiJWNCmFgwuNGUWfFsjqZNA/04
 eavbWM/pX+phmP7VtmI7usSsjDSOv8UOYADRMzWhZFBv/6Pu4GOqaFq0ZkRXGMi53/Xl
 uj1Qm6Hl+mOdSLyWVr6+39XPRm2ETh/SzHInZ42TbZlTigB2G0wbmYi8/DXbHDgS+mel
 3s9CMuOGsrZC81VsDpc1hD3yhgBqnLL6JqoYJxMXSDq0HTBwmhwNhPcPAlsej+YVQ8CK 3g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24ytyecr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 15:42:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24KFQqIM019903;
        Fri, 20 May 2022 15:42:43 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g22v6fppv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 15:42:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYMZt2+pV3QZIVZy1YSuMPVBYTQ5gJbMuIMeuwzW7UiZGFh1XEYwwtV9aeDjdIgFe78Gdxn/hc37e6Omi1YtB0NhhTwx3rYJHYaVwgyinx2iFvsP9PDqbZsNC6C/6e7474XgD//3QamdMtVT7dU3h4DyVg97qEIyRIXW57sDSNgT7OCIsf9sNRvLHoP/EWTuL+u1c/ChuFvFzcRVZ7jeFgJugEv90Evm6k39BjQRz6PgoLVHvGMZS19Mv35pAKlfTBamyEuFR8yuMREfbb34VwBwGHHFjuLtzquA92tkqKXuT8PDM+RgrF2+3HQOmS/EVvefbQchqDhB5YRy2Rplyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltoq1olNR8WJYwxw4Bm2LDNO1mEZyrvJflXQNQaCZjM=;
 b=MTlx6pgWlz8axf3QFClU3pGfRsHNkoTepBhSVQSQjowLqHB4QGogrjsyzkfHPJo3ueH64lZuy72JNX6eCcitNXZ9xxQ8/3vRyAZ3u7XDMEC2SKQTwcWh4EYyUjRoH8RFynHCmxl2CknlerSsa9/McsSLWQJgMbd6GWhqW/44tLNORC7L/TEZcpRDSgNIBbcNQfJD1fBGeTi0muOrDJtGXfOgTty9/c/YWOmXjBT6jPZDI84yNpJc0vlV8jKFD3EzTbBEA48JdfhQZdZeqftFgVbW7efsbJDZf8UcTJT8m0ewcvU4Z1mNYYFXnae58FuXGcfWqkammYJwWBD7rZmCjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltoq1olNR8WJYwxw4Bm2LDNO1mEZyrvJflXQNQaCZjM=;
 b=vWT4jcr458GdsnxvJ52ww1aCB7nHDMruJkD0pwL3OkJKIgDUrtjYvacTkmlRGTTZcgMFP46DfT0GlsQOnwkWF9a7A42/gMoQJ+kC7kgVdvqmQckV+nJec8cc24G3cmgikn+tNfSDMfjeC12LkWXl3xjOJHVpN7d4bMGhkafMXMA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5013.namprd10.prod.outlook.com (2603:10b6:408:120::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Fri, 20 May
 2022 15:42:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 15:42:41 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Lukas Wunner <lukas@wunner.de>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gavin Hindman <gavin.hindman@intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] DOE usage with pcie/portdrv
Thread-Topic: [RFC PATCH 0/1] DOE usage with pcie/portdrv
Thread-Index: AQHYYZpUtjXIlIqUW027xRTonVwuYa0TNHkAgAMcFgCAA8sefoAEVZ+AgAZGDoCAAp4oAIAApmkAgAABWQA=
Date:   Fri, 20 May 2022 15:42:41 +0000
Message-ID: <93582FA1-3450-4D1A-94CB-7C90118DEA64@oracle.com>
References: <20220503153449.4088-1-Jonathan.Cameron@huawei.com>
 <CAPcyv4geBaTkoJ+Gefgq6RaKHtB3NMh5ruZ-1yV_i0UVaw3SWA@mail.gmail.com>
 <20220507101848.GB31314@wunner.de> <20220509104806.00007c61@Huawei.com>
 <20220511191345.GA26623@wunner.de> <20220511191943.GB26623@wunner.de>
 <CAPcyv4hUKjt7QrA__wQ0KowfaxyQuMjHB5V-=rZBm=UbV4OvSg@mail.gmail.com>
 <20220514135521.GB14833@wunner.de> <YoT4C77Yem37NUUR@infradead.org>
 <20220520054214.GB22631@wunner.de>
 <CAPcyv4iWGb7baQSsjjLJFuT1E11X8cHYdZoGXsNd+B9GHtsxLw@mail.gmail.com>
In-Reply-To: <CAPcyv4iWGb7baQSsjjLJFuT1E11X8cHYdZoGXsNd+B9GHtsxLw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0cc5d5e0-91c3-455b-5df9-08da3a776038
x-ms-traffictypediagnostic: BN0PR10MB5013:EE_
x-microsoft-antispam-prvs: <BN0PR10MB50135F7ED697BA24C52C5F8293D39@BN0PR10MB5013.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8O9hSQcHAVLOJYGH71cJNs2KQOtsXrwpSL0X4EhpiD0335FZossV415dmczWTBqzma7QmUKGeGy6i0Ld5HdOe3sbYpdlfusXp6jBuE+bfgrPrBJUrBTQg22xdtgGyF8LviO5uY2alLG05PgF3XoKV6OrWGjFJURMXJuIJj3RIOx/cYb9ZK/R86Zyw0leXFfZNdFuvDxGLZhODW7l9UgDUK7PQZR0iWOqaElXczqdoOq6Xb7UI7BpPKq269JnOlsublp81Y9DybfSwdSrHiArBap+9NJt0PxguNNq1qFb3XCv4AeTuG7tu0OP0ka9bTXNhmsn8yjtQlrcIO9E8Qa+yfIPeoS4E3nxoUfY6XutNQa9CjJ+QEkv7PDrXp970OS2uKk2A+UikQ+B7xvRW12xN4X4kLUBxTvSaBRTERgFfrUAzI/Xn0/2GqPN2IgfxcJtq3fnbhNiN6hu68F1oq31zgtFgcmRajbqSiNaKbVKODTkj8mNJO83U/gY2Fz+2Vwv7l/RreHxyavjqFjaua7cFv01LbvH1zlqOAJR0NKZPnUyRPjz4sMmx8BQeD8+MPbcLIyUOfX0/rcV6xeZ7ndMPuIFX32Hxz/r6xNea2niQAw8YMVejnhl8ARtwMFUVNSv0Jxrc7ih75bKbi5QVO+FmgVryMw5Btav2wbkIivJHMOm6sttgFYA+D8kSwPS1BUc3JW/jCgOhbKDM88bidktMKew6+mGTY4AQ9wLU0OsOJAVZqDGL8TvxFwWm6CiqVxc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(5660300002)(186003)(38070700005)(2616005)(38100700002)(2906002)(53546011)(4744005)(83380400001)(4326008)(71200400001)(6506007)(6512007)(26005)(36756003)(91956017)(33656002)(508600001)(6486002)(8936002)(76116006)(66446008)(122000001)(64756008)(316002)(6916009)(54906003)(8676002)(66476007)(66556008)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G3p2aWccXI3tvTStXHrcnQbkuwaC5OBcXqzSIBe8Ii6A4QzAEfJ0CwcNYccN?=
 =?us-ascii?Q?GKnwBFuEyNNpb58ViRQ1YC11XHlJuxeI57F5z4vIABDHRjbXzwtcn09VaiRS?=
 =?us-ascii?Q?T7paTp+LsqCrhSKh6NfocvTl8HE92UARqFqyMnnsiM3kfcSvcMjcUpmlHqIt?=
 =?us-ascii?Q?aYwsYkeic0bWWwcCj0BWNr3z8dmZX8K85PMOQ+/RTHkmO1/omMKHBKieL6kW?=
 =?us-ascii?Q?RCGQqdjmd90IJa+61+VNc7VbqxgHRz26kUfMVZprfbRUjVKTzXHPCcWJxxHL?=
 =?us-ascii?Q?o+ae+G91CLvmm85nfDXHrqiBSqR0L4sqP8zKTMfqsr0rdZdiRv7n5543cxfm?=
 =?us-ascii?Q?wOMk/1PhAZ0wRl2e7NdENLCjRK6A2cYEjBGmDNT4mwbrWguJtQXo2VpJc3CN?=
 =?us-ascii?Q?pkxZZVWIX74Po21TirJderh9c4+bz0yBiGf7kMIF3hR0qWizoJRHBMdASx4z?=
 =?us-ascii?Q?A9OCMRy20m/KehCrxHF2Y/wjgwPZQXrNRPRAAQn1koFpURSWda8Lc9wggooZ?=
 =?us-ascii?Q?nEC0odnTzhK3M9e1rULavX4Gp19L5YtcairOD56yUUX/QDOHR28aiOUyAlpR?=
 =?us-ascii?Q?heJY0/seqiRkVBxTy9YP8u92QdlxcQA9dr6qRJwdl1hoPZ09YFKE/8aZvV2X?=
 =?us-ascii?Q?hIcA6zSuXM3GcbHJHhVW2Tr3aGwZi/5W4PAhP1kxxdE3KlOh/BgX7g9uqnf+?=
 =?us-ascii?Q?6VTtKhlvF/Nfre0Jj7wla7evUPB67zriTam6NlPzj+cyYJBYYbXYXGKaA6hj?=
 =?us-ascii?Q?1oEatSyA7Q94YXBATFbaiKNH50Hf71TzCCTnFRtJQuO7q/iDyk0Te6XWkT4I?=
 =?us-ascii?Q?wzCjGSOpGqB2s2LdXZP1rITC6Wj4r+cCLgswpOiFJAw3WLmbD3pHtDedeasN?=
 =?us-ascii?Q?dl5iGNQNH+Rle4+NB0jW/i804XpwX2ycRgYoFnJtVctXQY5id8YxoDa9BzUK?=
 =?us-ascii?Q?lDyRFrjfvlF77kxBaIfjiNOpga/pCRHXkL5stVoqVUm6Y/xrW/wfDebDLKc7?=
 =?us-ascii?Q?HY+956DcSpo6pD9xrqSNKvOnSbxX3MIgFhjCl+0kp886Jz6lfAAoUJP43TmV?=
 =?us-ascii?Q?YWg5uSNEnZb6pwnAtSYiGzyF0SAmk+eqW5eD3aCz5NDM4vSlGoO4G1J/VU41?=
 =?us-ascii?Q?C8XdUbfq3F5vLtnPpJ2JL0V1b1BKSYM5FPYmn8vFGb0ecPkYWFUUNgsapM1U?=
 =?us-ascii?Q?rVCNdHW9Cs4isRbbILRjoQIohhMwR6Zab4A+MX+pEG1z5xHRAQsBhC2UnRbr?=
 =?us-ascii?Q?q9mwJpkNaSaL09RQvK86ni1PPCKKZgmiErZeYfVt68g47hiM3F9FkigmMqI6?=
 =?us-ascii?Q?fttCF6uzzdd+GUS8ikHyDo9SDy+yUoRuoQoadCvQR93UCnhcIN2uC/OaCPCS?=
 =?us-ascii?Q?QtB/APjCj1gA306KiJOjMO06OSLIt1HexkIGOfCD8zYr4gCruiWVvkyX0xYo?=
 =?us-ascii?Q?6yoemoFssnoHPHqsfPZQPEdfbfHgUwpqlQqWmNs4KQ7QOWh3bZvR/qsbPNrh?=
 =?us-ascii?Q?IrEDe8Eq5WkKYuXgssEi0Hhp7PPhjdOs4cZ9KMpQEKD00p8sLfTMyTXm9Enq?=
 =?us-ascii?Q?9Pj2QJ2rX+6msudrEuFN5pS4CN86ZjFrlJb7G11Uph3AXn5DHtNeLM0NEglb?=
 =?us-ascii?Q?MYrcZsEyO3tYXotX03IzmaqXJBW7C/01lhy7gZsJJlf/+MR1sp+Py541j9An?=
 =?us-ascii?Q?dt8qy4agI4rM5UqiaJTazXmlhprOCg12qV7UVWH0t47wwoKYnLENyYCQz5HW?=
 =?us-ascii?Q?sJGBo+hNHnnjWu8bmQsM5JqyhLBpYJ8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D36A74B3A74CC643A66BFB0FBB13B699@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc5d5e0-91c3-455b-5df9-08da3a776038
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2022 15:42:41.5703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q1KS4/hY5lYZOCPDHnOZBDQ71Wkl3ZxsNbhDWvNMux6cJ6P366QgsQcqzqrS+y8Oxwm6Q4xOl8UWF6LwvD4b5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5013
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-20_04:2022-05-20,2022-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=960 spamscore=0
 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205200105
X-Proofpoint-GUID: uQ52l4iaDIMLERyH4E90GY9fNiEZG9o-
X-Proofpoint-ORIG-GUID: uQ52l4iaDIMLERyH4E90GY9fNiEZG9o-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> On May 20, 2022, at 11:37 AM, Dan Williams <dan.j.williams@intel.com> wro=
te:
>=20
> Otherwise, a
> ring3/ userspace helper that can live in non-pageable memory to avoid
> scenarios like this sounds like a capability that would be worth
> having regardless.

TLS has a similar issue: We would like to support TLS-protected network
storage for the root filesystem. The user space agent that handles TLS
handshakes would therefore need to reside in non-pageable memory to
prevent a deadlock if a new handshake is needed to access the root's
backing store. But then so would the certificate trust chain and any
handshake configuration information.


--
Chuck Lever



