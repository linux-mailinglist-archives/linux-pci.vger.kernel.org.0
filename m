Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3501522CFA
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 09:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbiEKHPE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 11 May 2022 03:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242724AbiEKHPD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 03:15:03 -0400
Received: from de-smtp-delivery-63.mimecast.com (de-smtp-delivery-63.mimecast.com [194.104.111.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FD96197F6C
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 00:15:02 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2106.outbound.protection.outlook.com [104.47.22.106]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-LBWVlm2jOSSyzLBey0CgHw-1; Wed, 11 May 2022 09:13:52 +0200
X-MC-Unique: LBWVlm2jOSSyzLBey0CgHw-1
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZR0P278MB0457.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:30::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.21; Wed, 11 May 2022 07:13:51 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f465:3051:c795:3c2]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f465:3051:c795:3c2%9]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 07:13:51 +0000
Date:   Wed, 11 May 2022 09:13:50 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     pali@kernel.org
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3] PCI: imx6: Fix PERST# start-up sequence
Message-ID: <20220511071350.GA9888@francesco-nb.int.toradex.com>
References: <20220404081509.94356-1-francesco.dolcini@toradex.com>
 <20220411165031.GA28780@lpieralisi>
 <20220509140919.GA7159@francesco-nb.int.toradex.com>
 <YnqlmMzOLSxjzHJi@lpieralisi>
In-Reply-To: <YnqlmMzOLSxjzHJi@lpieralisi>
X-ClientProxiedBy: ZR0P278CA0033.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::20) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 645137f5-48f8-4f28-0e5d-08da331dccd9
X-MS-TrafficTypeDiagnostic: ZR0P278MB0457:EE_
X-Microsoft-Antispam-PRVS: <ZR0P278MB045777D76BEB586F6068E476E2C89@ZR0P278MB0457.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: EfVA18e/vvgF+8eoE6XwI49URaY4xteCc6nPVH2TMcYHXq6qysuc/UxiZnSBHHjrxW2fpS+ovT9ExzTycFBihoYl8vDDKN5EMH3rvqg9paesK5K6LPRJhcb4UEvebai6lTk9J5iRHwEoPjLK2QuD40B3LEXCKsuVV7r/Bcq9PUht5P5j0r58SxWks8kwS8L2M46dxxnGLux7aZ1hkBuxCt6JaSTE/gqMMLZwiCpeDBzsyqQGsuaoQ43dWupHbq7QORtL1kTsJSHKIAy4WNedtoQ1SX/eI4+EHQsWj9V/KSCyumDTrgqk26F+GP/HAH63uNEwn+G0E/fLLLtTcCOv3o3WYQXiWYqS9jGQnj96dMS+hvSQIuaQMKg0aZIJfhIHNpsZpslweoqhIKYGkeoJDowr4LtLkA+ROn9kcSfMAXyC1Bn/XdH4zVOG3xs2EkPawRBMwSPbCuemVYdjG9AHaCxUYz+EebwJEacYfGQt3+Lj5a7WFckeOU1rkwPKc0ZWJ4qrMfbmLusaAZ9F5TmVR0aqPrpbo3g1h2JNOPYQRv1fUZZS3JoONjvRYyAoc51n+MMAolqpFdvXJugNZ0oZu3krD64Xh3THG/9kycBOgwq+hUfVOjmNHbpPeBwiS2H1oy9yy0yzE/GPgB7HPfKj8gVJKLYxkKmtz2SEnXprrWTeu9AF72JO9iSgI47qNMQVCwgk/982VeJJ8iBDZky8/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(39850400004)(376002)(136003)(366004)(396003)(346002)(5660300002)(7416002)(6916009)(38100700002)(38350700002)(33656002)(316002)(8936002)(1076003)(508600001)(66556008)(66476007)(54906003)(186003)(66946007)(6512007)(86362001)(4744005)(26005)(4326008)(8676002)(2906002)(83380400001)(6486002)(6506007)(44832011)(52116002);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?twtl9cr7S6mkp5wxuxCti/XpbEcHjfw2TDY0hkGbKEluvzkyJj2GPxqEd2OE?=
 =?us-ascii?Q?+ZbmorPr8hlGY2x6yhXdNoTJRDCqCnGO/qXNNAzsK82pi7O06QG5B5zgonN7?=
 =?us-ascii?Q?j5tMwhZlL3l91Qht7p58NskbHlPa7hLVRGdsF+5HWEjQ3CkN5IZpu/CevNor?=
 =?us-ascii?Q?CiidX7HNyibrVlFa5PhzUSpt+m9dmjVu2IqcdG0lGeG1ERF0hflcEQkiimdk?=
 =?us-ascii?Q?51CpnziPFyRs9HxQX8N2eunL7V7aDSLYI1KTy25WuScF0fA6i2rO4YisqipT?=
 =?us-ascii?Q?NJVugBkR12lOFcQmstkZ8qsgOjtvb3Qa1o/v3Jv6gGNqkOzKhorNrd57CE9e?=
 =?us-ascii?Q?T3uLmkTCsklzIsfeD+qUMRdg2j230R+YTCyFJ4x4q4SMV9xDepVAxlZ81SCW?=
 =?us-ascii?Q?hEUzaIamQ/MVHoBcLkjMd/jX5qodDJ8PEb48UHhp6XAUjA8e+iVEsZ5U3Xkb?=
 =?us-ascii?Q?hvyCKJVgu4ZrnESYwInB6aEKbPMdFjIQspbMif8D4xGc6DkGZrcwk9gEj751?=
 =?us-ascii?Q?vXe2CPH27+HpakO9SD2UOwNJWd4A+ToWHCB6MzutdYjQ1/noNl7IvnOIIVS1?=
 =?us-ascii?Q?/Bt6GkzZ2A9FWcIsYlTDGqUYd5M/eHG+ri5OIZke+EcL+c4nZIknp0b+rXqF?=
 =?us-ascii?Q?iQrMjvO5IPVFIHC81umO5RV2+SqYb5HuQBikbWwhKUpA1sJ+WGCRoDt7PmCw?=
 =?us-ascii?Q?/303fEfHrHuw7GPrShXkaDcvJGkVoxAKNyBfm1vKWGcMAUG5hLCGAzvyZVSW?=
 =?us-ascii?Q?vDzlUGFPw9SVcbpsVWAZZPmHz8nhjLGmK06mbwmnYLJBnMfVDB0mn760RCL5?=
 =?us-ascii?Q?2d/qQtIEXKTBcAl2fydrN3qBLjaUOGRceQMatSX5t55njfQ4d7L8ST9EdR6V?=
 =?us-ascii?Q?Pb5LfSKg54HsACL0K9IGvqh5pkLKJDZxuJV9debROZxH7g5sWT5f/dR6Z9iU?=
 =?us-ascii?Q?h+078XXHeGvwlDMy1JVVX6qI0fqG2r15IXqB+E/Ah0lm9BMr0WMYH2le7eLA?=
 =?us-ascii?Q?m5bRSgjbO1FO1feFxk3Qm7d4/NPWote7VJ6QjJjgkPq0EdHJpEDu+f6JKoCa?=
 =?us-ascii?Q?7tEA0TCkTVo8i6IcfbPb1z6+ear71mfYFb+Y4z/FsU/hj/WsN0LcWIPNVypK?=
 =?us-ascii?Q?yv2ZNgRSxHhPCLV1gF3iJE6Ip4WGPi85vi4DldwHXA8pU4tJre1AjfBRfMf1?=
 =?us-ascii?Q?VQXbiV9lgGTJRXUQx8/6m7xsh0tvJ+FMbniQyv3OwRBoTtMIfj7cBVJ5kSwK?=
 =?us-ascii?Q?q0KwspulNUDkZahjbL0GG9HezyWQr7mHpbpcu36CNS/60Vp7gXhnA9bY/ngJ?=
 =?us-ascii?Q?a3Wkh+311rYNz09rc3PBbcs0ZliHTmk9oevE9BbNdf5VpGUffH2PJO5NRWLL?=
 =?us-ascii?Q?C41S6NUdaPKE5nncqTYmaMD5JXT3e/cUjdZysNBWe8MNgozOt6nlLBeH7b51?=
 =?us-ascii?Q?kouBi+Ld0qMGpBWBu+wHpt5whMdd0bF9tA1j1p7XZ4adext5RZNHkJGhZa6I?=
 =?us-ascii?Q?E2Dpmy5tw8UY3iqGxli7JWcYOutHrplwm1iCM8pFSaVwdYvNG8hY5nr7kMxx?=
 =?us-ascii?Q?wsMSsU3iJlnJ1zOEPT+EP201RDo9m+VbdQMIlGqNEAskhBIJvQB4d0lOR4dz?=
 =?us-ascii?Q?3iJgJ3azDvzLYp2fqhwuS7RnQBvc20WlVPAspnFtOSkNRhqgfkA0c8HlMDtc?=
 =?us-ascii?Q?CI+jnjg6bjoKzHXP0Uah4MH6iSreUpNf7G1N4kI787cCJMp4kN1T9pqPOyuG?=
 =?us-ascii?Q?fWlowiad8Mr6PXQxpoxRG0aFqsDFvps=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 645137f5-48f8-4f28-0e5d-08da331dccd9
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:13:51.1597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ecjHlwGjp14pet3/lDIivFPK1c3l9k/kNCQTRMQ4avkyXHIXQ48nDcckPnkmvIRSr6D8ZDV/eexm4oA8aRwUx+XMPoyCOYwCiSxeu8YLlyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0457
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=francesco.dolcini@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 10, 2022 at 06:49:12PM +0100, Lorenzo Pieralisi wrote:
> On Mon, May 09, 2022 at 04:09:19PM +0200, Francesco Dolcini wrote:
> > Hello Lorenzo,
> > 
> > On Mon, Apr 11, 2022 at 05:50:41PM +0100, Lorenzo Pieralisi wrote:
> > > [CC'ed Pali, who is working on PERST consolidation]
> > > 
> > > On Mon, Apr 04, 2022 at 10:15:09AM +0200, Francesco Dolcini wrote:
> > > > Failure to do so could prevent PCIe devices to be working correctly,
> > > > and this was experienced with real devices.
> > 
> > Just a gentle ping, any concern on the patch?
> 
> I was waiting to see if Pali has any comments on it, given that he
> is working on consolidating PERST management.

Hello Pali,
any concern on merging this patch?

Thanks a lot
Francesco

