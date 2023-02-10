Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F186925D0
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 19:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjBJSxA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 13:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbjBJSw6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 13:52:58 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1A777B87;
        Fri, 10 Feb 2023 10:52:57 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AI0Aei020851;
        Fri, 10 Feb 2023 18:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=/5w2EAFp+CESb2hH1LLBk7V5FwIcH5Vj4gFiUy5Or+o=;
 b=gZk7VRnPlNpsjrfCHKHDyvbAzRc8/rrsWGgTZvMjYZXKyNm4LIgmewBR9ydtXosc3Kef
 Ob0WBdMvi707k5vxhI4mUr4Gj9opoz2taOl2ZtCDkxL9STSV+dO8AKDzjTdu3KM8Uuk1
 5BzOfvUmT6cknAA9zLPEtZVMpVY/1Bry2GaPFc97S2HG+O0MsrtlQJDdeeepvnnoarV3
 eXnNfPQL7Sijb0/1slFqlx+ko0xT6oU78UsYOefylKy16EgXIgEekYeqTArTgiDjGZF7
 rJmxSuv1lARwsGkz6zTf+F/+zOM7CWc/RbitkYJ1vq+TXN1U6F/8vjaj8wXl5qddlv95 JQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhfwudxkb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 18:52:50 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31AIpooq013637;
        Fri, 10 Feb 2023 18:52:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtamnn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 18:52:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/YHQthcLGN9dfSJXyo5ilxjqu1o0iqj2NgQkA/jeBmhJZd1ip0ncFDA5SQwbvrVG8ZSg0RIBGZXVc4pErU7Ydhrn3Z4NE8BIax4Icxz0j4nDJnKgAC4MAwAlGfMiZrpZVQU73AUc9WNnI0j+pQDmCfEVmpRtVy4PIEpBMTjrqtN6wP/ZfDV1AOLVtGoHzeOrOZ1J3v2vu2IQKcjVhubtFyw3mZZBbU7y4ywXKihksWjoNKMJ12+M62oXjEAPA0rsFd3ZdM6+or8jKbE/93hfaGN/56z0peYdunNBL+sJCRm82Zlxr5wkU7Kh7Ye6nUTySeeHHtPnN4jDbqC/+7ePg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5w2EAFp+CESb2hH1LLBk7V5FwIcH5Vj4gFiUy5Or+o=;
 b=HBp1iAzwRMkb1RMXtOTxr5j6nrSS0N5wn0PzTijne2ekp86xwKzXUm2zj++jR9rPs230XGc8Tx2jgQyqclOrV+LEzl1YRjxtTMcEmpZPGv0km3NJf75We9Idx6MkttISFcLMjNCMssRY4El50zrFYC88MsH3JT0XBetCDlI0gv9b6tKv3v0PuJDfifjj2lDi2MfqkrH/D1iCIYXROdsuHswHvP9jkLsmWHIZgXaN1IFCUG2+kD5uGguM3y+cJb6y0zfpOTBjq1IxhUB867lGeLIwU1h0mRrW0nvC81kdkdbZdJ4afEFAlGfQptmv/trO56O+UP/2J74cWRCuljffaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5w2EAFp+CESb2hH1LLBk7V5FwIcH5Vj4gFiUy5Or+o=;
 b=R4jFfI1pSSQQ36jyCEMF4lHs6z6hYxt+m/zNWb/Uf17fdQtl73X0Kl5KHbYp/YgFyk15kEwXYBC/ZhH+ItmkdLGxcL7FS5nTPxTnXyPwjiJS2hRnpfW8NnG0THT/Lehxhp/8BlxmC5QLIxazKQM4E7kdoyMnxZFl20FwS/vC8NQ=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by BLAPR10MB5042.namprd10.prod.outlook.com (2603:10b6:208:30c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.7; Fri, 10 Feb
 2023 18:52:47 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d%5]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 18:52:47 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Rob Herring <robh@kernel.org>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/8] kbuild, PCI: generic,versatile: comment out
 MODULE_LICENSE in non-modules
References: <20230210164749.368998-1-nick.alcock@oracle.com>
        <20230210164749.368998-2-nick.alcock@oracle.com>
        <CAL_JsqJ_VhesDZO336tw=KAp88jCLdW9C6y6QDkTF7WpLkr3+w@mail.gmail.com>
Emacs:  is that a Lisp interpreter in your editor, or are you just happy to
 see me?
Date:   Fri, 10 Feb 2023 18:43:45 +0000
In-Reply-To: <CAL_JsqJ_VhesDZO336tw=KAp88jCLdW9C6y6QDkTF7WpLkr3+w@mail.gmail.com>
        (Rob Herring's message of "Fri, 10 Feb 2023 11:36:16 -0600")
Message-ID: <87a61l1hum.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0039.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::12) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|BLAPR10MB5042:EE_
X-MS-Office365-Filtering-Correlation-Id: 3871881b-7717-42f7-5760-08db0b98007b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i/Vvs8aUyfGLY0fzMu3ESTa9TZ2d/UeLojq6sNK31BiMB2ebXcPw3PnkYA/BboldxRCZB5Tj+PbA/Wj4KUoTEMVnQbXUr2Sg4Fgwh8p7jodzl3KIkP6CGZYbJesndk7p3Yl76Hwxlfy0jtfYBK8pwZV+UFYcT0A77B4hZBpTOPVP338Off6kmkLDcCacaR4W43pjGyJ4qWuv7Y9vonZyQOSo/FlhurFHkp8dEiUtJFWSmh234wLsReRcibf+c1JzT97SQDKSJ1VzGHJ4Mt6Qc+qDAriFoZ8ubfE41EVUyaYaoawas3KKl7M0JgltrgJdMs71wOBmIdJzyqxlWwuw8drjdGTPbicinz5BUjx5HKj3PXuK7BoNRWKVYbm2L+Nl+I2x7SzrsfiNO83Q3R7YmuvIghByDIJcEK4+unuz2p1W47dDZdgzWcfHULy6HgGmjsakq76qrfhbjVsngc1qAqGkfy69pCst1cX+WATrSea2M4+L3pwi+3twhwZv7RTK8yoiGd1LP3kXo9GeXa8jFYmKIfuvUTY3ubTsOamkpECWV/yMhgAxXjD1K0h/0tyxRZCamEi/zC24N/B4d9e6hHHUtNDfBjSmoE+MvHNjNS9IN+pMWjJJ5NB4mvkOJh12SR8Si78MO9jHrTfkmXnkaSxdHO6diinMcp1Cf1imCKFbreb9/JCdhhb3uKCklJiO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199018)(8676002)(186003)(66946007)(66476007)(8936002)(6506007)(66556008)(6512007)(6916009)(4326008)(36756003)(86362001)(38100700002)(9686003)(53546011)(2906002)(6486002)(44832011)(41300700001)(5660300002)(478600001)(26005)(316002)(83380400001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yH6rQPs7d1PJ46uuhKN++nLqa0e/+gfGUmlBTDY4t5sLHKatWNXZK0ggncwm?=
 =?us-ascii?Q?HJO+mgDms88bI7HpFXHGc2fI4r4FpMGKCEm6g8E9BNs3YVK88s8G+iZyx60H?=
 =?us-ascii?Q?Cj+3nTh5wnQhdSTd28wLppfOaRHjsk5zY4vAIHvgF0WDHt4AmVXeCK7ckkcX?=
 =?us-ascii?Q?NqbX5KOU+ZjucFzYFjtoaFHOAbBcWPNS3mC86X1abeAuowwzoQZOqLYZxUsd?=
 =?us-ascii?Q?7KaqW/zg8nEGEwyIoUrnchIsxhflFKiSX9b5o0ZM6xfZd3Y9T3URJJVe9uSW?=
 =?us-ascii?Q?k8MWJfmWYirDsl9G7FbPLuJwcRJPrIwfEKOASHOyO0YL9KRq284YX+3VIgd5?=
 =?us-ascii?Q?Ky7NL5PFUvl+08acc8gmAp73NHHPS9hoRNarzurj4qs272BEkzIxNKVvwuHP?=
 =?us-ascii?Q?WyScE4v4Ur8eFIPOGGkZfAalC14qCuwgpFXtw5ysXNpTSGVn0KADS3L5TseE?=
 =?us-ascii?Q?yDOK6oYus3ghiQDauTZzA6OOWQEJZhcxxbxm+ssv5G/hl4qYBE/nRMzIO3ns?=
 =?us-ascii?Q?FU9+IT96RIvpQXwcUR7VBUZNkQdnbaU6b958bMP2+Jqnb3I8CJajoLjltG5D?=
 =?us-ascii?Q?SR7d/l1xaQX8eUNstwSHenjf5e9WqqgX3d0mkQ3PpLnHooyNZJ2dUW6IoCrt?=
 =?us-ascii?Q?uohssRsvdVBGDvGpefbihdJvml3YW84LUYPTZOK1HJb78qd33zgP00OXjiyc?=
 =?us-ascii?Q?H8dfIojVWuRMN5Le8bekkoG77WKctbw7r0UWjKbiGP8glKuaf7cjN/tFHA3X?=
 =?us-ascii?Q?nidwQcPS5u+L0Fu8cBu9xqHqlAk7X3nYr3dQ/tHEArrO0k0wePIlpptnsS6N?=
 =?us-ascii?Q?SGNvimySNUXnVM8W6PQ1wZS6gdlXkv4/FxZftH3P9X0Gq/l/u7QD+bqVm4EP?=
 =?us-ascii?Q?M1XYAvluMhrWbqap9Wh/ex2ys+fhZb4sSdAP81RuobEiCXrBPvY1ENXc7gpQ?=
 =?us-ascii?Q?1qaw/7FjFW/jTumU10+g2DYZOdo9Fz02fO5+eX+TOLUnjG9aGiAU57w+1CZd?=
 =?us-ascii?Q?sE471yvK5hj0nS9aqNYGWi3oMmq2ChR4f/TEcHTepCLhcMa2u6wpFVM6tDD+?=
 =?us-ascii?Q?Y37ikzIRM81bHw+Yu1nL1SaK9egabuaFXdHuvF6FI36y8h+ew99ngErGQXEY?=
 =?us-ascii?Q?S417zYwgrCYPxbG9fBwBMpNs7noIcELxMyhVmtFOIQlJo2fzARerpO+D6s9E?=
 =?us-ascii?Q?F53XVUBqGNnu9aC/j2uUe+oVtP0XYYYgMOGI94FDVYOs3wqxKA62OkUgctV1?=
 =?us-ascii?Q?K8XrMBpshqi1A6W31xM5d613MQM6CvQto9ZWgpQnfj3tGCjoac7fxelAHib8?=
 =?us-ascii?Q?m+FC9XOpi8M94Q64OiKcNQ5adEaK8WaNtmcMsPgYrnlw8wE1D247v+0QKScc?=
 =?us-ascii?Q?lqxpeozqCj/ImlZZjEmNzn3Qjzf0f6NSSpvQKYfQpd+jPlBSXPXMrbpEmsR9?=
 =?us-ascii?Q?qfdiopg4blQ5W5oYBFR2zozvWmkLJyUuonRrKWNkL7PjqhBhjaVIhnrw23uP?=
 =?us-ascii?Q?DrfyJHb4hb8eFKKerfTpYazgmWIAqNSnmxZ3cyAb5sDIP7zwAC+QZ7EZgDWV?=
 =?us-ascii?Q?a87AeoIY2mt1hoqXWVstTl7NY0eYW+yFHYbknX3v3YCgpl6DQq1DzIL3zRbZ?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vpwtPnYXJwHZkJdl9h6XXaHBRTiMVsl7XKpr/sLkg5NNUrPqyVDljkFM3wDJGcJau7UHz96ZDO5XSMfPP75IA/nko/dwzL1SLvlX0wV1b7AhlsPLXSzzd3wX2Q5q4ckA2E5pgWCqa1T+KbiLpmK9Z9Mvh3YSKm7g/z31xLyx0NI1uuNQQT4tOtxx/qRohkUmym6RqFOdFmJ58n/nsir4oc4zW2UT26tT9lhlJVLuK7rt5kahh50RtdbepImDSzs4Ry5NIMYi+ggyYQy4BIdLUTLvSyzEAK8AwaHVUj83MXI0BSDCFaZfiiYVxEMz6srMpQYNWp0cX/CMU3lG+JBDwv/8qh8A9ffSrO34YBHbRxtE2zpGAJ61TYbWFxt34knZ9+8dQI01TNTJRVhIGqsyY57z7SQ3w6tSoTMyFMWuPhPX9gwMHrFpJ2QpYIh2F45pa1Ir0I0ol0WrgOoTJtmkCCf12CnSH0NgLjqmEE4totXoVFGx7qm6cqjuhVUti3EuG1Sy1SMN6FnuBKw3xEDFWPbV/stnlg0kDhfE2BuiViQGHm76g6LaadcQVsxxdlrP4in4HYP+2T8QQ5sEPQaLivmWJyQYlKGilZPXV0HuAA4hRXg4FZ4UPtqereasSDyDj4itP0zviO5VH1m/5maAdJ+5hTuGbyicBRGiN5sRQhkQs24osmwG8swFKfPK57TI7LIoPiCZNOH8TzDIsk5Rulg1EdHtiLE7suYzA9bxqoGY8mQ97nPHXFZJP/LVJNSHOkqPODc/VQzLVQ7FkLPLr1lT9YdHPKxkDBs4m0Z2edEQ9EFRZe53oyDhdT0c2q/MMjvBPQH+G3yeLSvJ5uy8xQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3871881b-7717-42f7-5760-08db0b98007b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 18:52:47.6591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: axFdEzxVwdV7QVYrG3UjpJUp8MVkY7VKNnqEghXM3OQjNeda0SnUnBEfin7tCCfTE+nZgH+frCcOuZ2g7WziKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5042
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_13,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100158
X-Proofpoint-GUID: QdfIk99bGOaisfijBOfLuR8S-rVqN2zT
X-Proofpoint-ORIG-GUID: QdfIk99bGOaisfijBOfLuR8S-rVqN2zT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10 Feb 2023, Rob Herring uttered the following:

> On Fri, Feb 10, 2023 at 11:05 AM Nick Alcock <nick.alcock@oracle.com> wrote:
>>
>> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
>> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
>> are used to identify modules. As a consequence, uses of the macro
>> in non-modules will cause modprobe to misidentify their containing
>> object file as a module when it is not (false positives), and modprobe
>> might succeed rather than failing with a suitable error message.
>
> How is there an issue when any given module could be built-in instead?

"modprobe module-that-might-be-built-in" is always meant to succeed if
the module is built-in; but "modprobe thing-that-can't-be-a-module-at-all"
is meant to fail. e.g. on a system in which ext4 is built in, I see

loom:~# modprobe ext4
loom:~# lsmod | grep ext4

(with either reporting any answer, and the modprobe returning exitcode 0).

But trying to modprobe something that cannot be a module says, e.g.
(sorry for old kernel, just happens to be what I can lay my hands on
easily right now):

loom:~# modprobe slab
modprobe: FATAL: Module slab not found in directory /lib/modules/5.16.19-00037-ge8dfda4e77fb-dirty
[exitcode nonzero]

This is what is expected, even though slab is built in. It's not a
module, it cannot be a module, so trying to modprobe it should fail.

But right now we have things like this:

silk:~# modprobe zswap
[nothing, exitcode 0]

zswap cannot be built as a module, so this output is wrong (and
inconsistent with the slab attempt above). (Sure, this isn't exactly a
disastrous consequence, but I have other things I'm going to contribute
after this series that depend on this being got right consistently.)

> The general trend is to make all PCI host drivers modules, the primary
> reason this one, IIRC, is not a module is because it is missing
> remove() hook to de-init the PCI bus. Not too hard to add, but I
> wanted to do a common devm hook to do that instead of an explicit
> .remove() hook in each driver. I suppose we could just ignore that and
> allow building as a module. Unloading is optional anyways.

That's perfectly acceptable for me -- I'm not saying that these things
should not be modular, only that *as long as* they are not modular, they
should not have a MODULE_LICENSE. Making it possible to build them as
modules again is fine!

-- 
NULL && (void)
