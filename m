Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6A051FF33
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 16:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbiEIOO0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 9 May 2022 10:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236751AbiEIOOY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 10:14:24 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 May 2022 07:10:29 PDT
Received: from de-smtp-delivery-213.mimecast.com (de-smtp-delivery-213.mimecast.com [194.104.111.213])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 795CC2B1DCC
        for <linux-pci@vger.kernel.org>; Mon,  9 May 2022 07:10:28 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2110.outbound.protection.outlook.com [104.47.22.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-wQPcNrBsMYGr5UYcBwIe5A-1; Mon, 09 May 2022 16:09:21 +0200
X-MC-Unique: wQPcNrBsMYGr5UYcBwIe5A-1
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GV0P278MB0386.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:30::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.20; Mon, 9 May 2022 14:09:19 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f465:3051:c795:3c2]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f465:3051:c795:3c2%9]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 14:09:19 +0000
Date:   Mon, 9 May 2022 16:09:19 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
        linux-arm-kernel@lists.infradead.org, pali@kernel.org
Subject: Re: [PATCH v3] PCI: imx6: Fix PERST# start-up sequence
Message-ID: <20220509140919.GA7159@francesco-nb.int.toradex.com>
References: <20220404081509.94356-1-francesco.dolcini@toradex.com>
 <20220411165031.GA28780@lpieralisi>
In-Reply-To: <20220411165031.GA28780@lpieralisi>
X-ClientProxiedBy: ZR0P278CA0166.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::13) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16d7028f-4e7e-4a76-f371-08da31c582af
X-MS-TrafficTypeDiagnostic: GV0P278MB0386:EE_
X-Microsoft-Antispam-PRVS: <GV0P278MB03868046BF83C2C938C489BBE2C69@GV0P278MB0386.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: P0NU6cgn5Oadtw0Lx+o7Orkg61o3U32H8g0HqREMpa39JOPYFdeAOPDFjOqZWwIvynWgdIxmSZCY8SGN3T9tL+Z34nfHldozoqfUY2rTJghbvnfMcz72Yl2b9l7HPtNtxRS8HutKRDV39t1Zee5xS3immRwCC5RqK4WQ2q6Q87R0bglFq2SfHgHIq7E7W9d4Rcw98J9cPH4TijRT3BgJtqjrAYWJN7+HSXChNbzetUXOUwqIsei8qht6iMatgxhmNQPK6i0FocMvQupA43KZMtZndEtj+gIVdPi6UBhBRwSZElTKKdeWRmZuOALZq/kIkAmx043P8dFBsG6o4k43ePKLjaXNSWD3nIq7GBfsOoU/KRCOn5CxhyyM9bZ+2AVnYnu/K6f+ivNZ5ZjvJEkGxpqbkhp/4JyYqUPI/wfRfvXRHk/jZQDCKcBxxhhcDGGu1ktQcoPjcm7svYbHfXy7+SdqOSQEdF7tzWNxC6fOPG1TSKGlEs4C7JPgumAfHwbd5BLVZncQqpG8t82QKFvZSoPZ8VGob+NXRWFm+0hIw+iczti/jrYyLa3SSSZuxfxVEL7iTeHJkrMKEL8pD7lfOYW5quF/mDaelbLv3XIPqqkov8zvX2x8FfQVm22MKHTWX19m8QL8mo1vnSYIcgY6gQ5OTggLqI7mW6/CCg2YV/XzRF3B47rjDDeBZC7CpxhfON5Xz6fD73ghPwqU5X+/jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(39840400004)(366004)(136003)(396003)(346002)(376002)(7416002)(4744005)(5660300002)(1076003)(86362001)(6512007)(186003)(26005)(44832011)(38350700002)(8936002)(66476007)(66946007)(2906002)(66556008)(4326008)(8676002)(83380400001)(38100700002)(6486002)(6506007)(6916009)(52116002)(33656002)(54906003)(508600001)(316002);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LK7wUHy22HN5AijyDj4kw/ymuWMdrKDihiinm9IhXC2A7aACD19cNjD3Iuna?=
 =?us-ascii?Q?rRXFrSGwuTuIlnVhuStZ++RrZfl6A9L7QFSY2pkhMAe+QS5lZOxPT/F7P8Bz?=
 =?us-ascii?Q?ik2La0/cAiv+S5bgi+v02zZimF5XM37L76wDVJbIYsXljjotIl4RazWtbI+N?=
 =?us-ascii?Q?Wx8+QoOsMiC39SJo+KTwomF4V12POl8Kd4zf9uTfADjUq3XaaVHfCH2MK/tv?=
 =?us-ascii?Q?rnMKH7qxPnqKHLZy4KvZncqs5/Co241VmlJ1fLdMbmov6TcMLBs3lEd+4a7Q?=
 =?us-ascii?Q?dYeJlrtS3g6r70LiWxyqQ6Cjfgl3MKLJKK//j77FBmDiQTnNJZu8eqwthpUa?=
 =?us-ascii?Q?6whyohYkEIoAl2K8lSWeBHz9grXxLgfAVXwtT89eYHGbsrnXXF6Ya6JzQjJD?=
 =?us-ascii?Q?YJvxZrjjab4JF/dowgZnxepxb4RsQR9NxQ8Gz74ZPE2c7bC/hxiHOnjrupdK?=
 =?us-ascii?Q?ou6LbNKH811WO72/dpIvKGwJ1GuQIYAGri64TOo1HgvYhPesdVVWpaBAlZHH?=
 =?us-ascii?Q?cwvSocThT7AAqow4Vy7/AZnZ6nBdW6AWMpAFwmTfFc41ox4bvSMorORKeS4r?=
 =?us-ascii?Q?TbjdruBVG6pAICRXvD/D6Pd6JFr8eR9qcCAP/YUClRhV3RzLa9uykSOgW//g?=
 =?us-ascii?Q?uXDoZLJ+gX2bkx/1LAksBe/JsrVIuaC/y0Wwd1a0uorjEVZGNrQSWvDSh9P7?=
 =?us-ascii?Q?nN7JBk9x/wZRf+Lw9nuHe/nNKqkVb2Dt/1tyAnhUjVFg9t+BPKUTGQGagNfV?=
 =?us-ascii?Q?yU5sEpZvtUY+rx6piwrF9bvzByWlXD9n7LKMx0wXl0FoO0/nPtJjJJ5Eu+T9?=
 =?us-ascii?Q?IODEvkxbLdQQPYyYM0GtAfXZQnLjz35pZ8W4OUwrJKCprrPhFz+5kElUY9d9?=
 =?us-ascii?Q?NqfWXpj7tBFE780dJSi4Xob3lVs705HOpPWCAwuTGvmrVIipHX6Z3GWpuD9H?=
 =?us-ascii?Q?6DMdWV9okxRWwOb8pi/53kdCqXWtzFoZJbKW4/BYuI2h73LNG4NcWifKrmoe?=
 =?us-ascii?Q?473sI0R0sws+ougNF2jqJAC3udAbIjKXOIPQmwbb0NfkQ2jTDSYQmIU7nk+k?=
 =?us-ascii?Q?WBqT/tXtrFMDlW4Nf5tCUkNYnbbvoH6u5sKvIVqeL3dAkUxgI8uP0ZxC2kYW?=
 =?us-ascii?Q?e62hmvaYjsOTBQUXDrTgwA4FaX8Ewk43Hmu902lcjaKhxPH4BSbF/BTv8h9c?=
 =?us-ascii?Q?O0IPvfOCUxBO022CPyXlIFJShql25Ec6hWYf7GWQhNmGnbET6Oa/DKi94a5K?=
 =?us-ascii?Q?dGN+LEPDR3/JgF5IH7TgjaZRb7rsHbXvLL6VU5IbChQQtUp9DIU4AZzDGWg4?=
 =?us-ascii?Q?8kj/T14p14oxJKrXvcyaZAQvIK60FTPkoNdEcRN0IWhI2DUc7/FvbLP2ISV5?=
 =?us-ascii?Q?OVRqUbZHTGWDwU+47VVQ1i5pLalVYGQyOSJ+CrkH17LQms4jlPTmLkPNH1I0?=
 =?us-ascii?Q?irEqCZO7pozh1CT1zIAKQgfnOsCF4SHNm/sHgFus5pEChjySUftyfwXt2q0E?=
 =?us-ascii?Q?zikstW/Hypr7pVvRTojRCQ/GA+QQqZ0nCsx95DJB/SNWPXdGM1zEvDYhKkdv?=
 =?us-ascii?Q?se1U+UoSyzMVbn0nhiwV/wbIfWHB9Hmjk+jabrtrc53e2EYhD6Z4a2DpoofK?=
 =?us-ascii?Q?odlAfLO3WMBjeVc1seUGrRh9eUT2fYHAru4tcAef1MlItZauMUFcjyQ7poN8?=
 =?us-ascii?Q?3pb3pLcq11FMhME5oDhmBRnz9VEbggI+vTRMnV6uPcHXQ27O2RWrEV3zhco6?=
 =?us-ascii?Q?0RZiZFA/dqyDV0dm4RiL4Lgl17/0M/A=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d7028f-4e7e-4a76-f371-08da31c582af
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 14:09:19.8015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: By1Jr2RoY6gCctwHKH/7vl+ivrmdJyc5iq9waOO3anf+9LYwR7BHXcGLHRpCNJzWChJfK96Z2fX1438TJl/9tNMjk5Amlm+VMScHWJfbRdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0386
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=francesco.dolcini@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Lorenzo,

On Mon, Apr 11, 2022 at 05:50:41PM +0100, Lorenzo Pieralisi wrote:
> [CC'ed Pali, who is working on PERST consolidation]
> 
> On Mon, Apr 04, 2022 at 10:15:09AM +0200, Francesco Dolcini wrote:
> > Failure to do so could prevent PCIe devices to be working correctly,
> > and this was experienced with real devices.

Just a gentle ping, any concern on the patch?

Francesco

