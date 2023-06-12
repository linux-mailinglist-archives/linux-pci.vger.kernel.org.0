Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AD172CB3E
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jun 2023 18:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbjFLQPe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jun 2023 12:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbjFLQPJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jun 2023 12:15:09 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2074.outbound.protection.outlook.com [40.107.249.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302F9173F;
        Mon, 12 Jun 2023 09:15:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iopc/wPnP9YDbOeS529Fs7PYk0CuyYYlPNVJVoZ2biE2U4T9dC+2hOLHKIiqYJXmu35Zy5fxrCtz1NbvxcqMShbjq/X+HXim8npP3Yk90uLTyUETQffEwwJil0NgCFrTS0iMuUDXE6cASjWusv9sABOdoTwFnAKtMv/crFMQ/fiHizCnvB3NM7RKStz/U6ET4B8tjxilDR3pIw7DVfxzsCdWMnNyXM+VR4nFPx2aHbGWQ2VHXjffnfOb3+5MW9eqsbH8GftpjKrtpDIzFGbdDywmvcaXF06JOBbciMzVGSS4h7UfWjt6rvogIGKVyd9OAT6Xw8ijQdKZnFmPnBEuqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vB+6QP6Z9zFjflocvR2BR9Lz5ffPZmTJrldvAi8H9fg=;
 b=ljFTyFaBGaEa3XhOs6WXzLUUog0wpYup6B7yGvg4IC4Cjht6fJI5ZjdPnhPukmHIDnJ5mocKoZpKc4Xz75/XgzCxrSFVj8AOSFtRzYTz8W/JYxlaWy7AX7LcrRW5XXpVn8BSn6FrGKwVhU0q+a/np5XXcgKLK0r50ZZpLUX/7NnlpLzzl6Aw9jKyBdtNQj/c+FZAHoWJp/N6qwqGTA4rr+vWtY5hcLlIZvpdnpo8f6IQh+Fel+fVVf0uuwx6T0Gbx8jBdq1ATdJDJTsIJfSmcaE7SucWJGX61HtXBOx+2b79yuEAlnEpcsOrBMEBxpvA8pIJ/13XvznyiO2FVAmEvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vB+6QP6Z9zFjflocvR2BR9Lz5ffPZmTJrldvAi8H9fg=;
 b=k1Z5hAQ7JRTrilhzvEE5UDWT0bxoWjH20bjohdpvpwdrb3pf0YH8WadybHFoB+RP1zwy/jD/rSfqrIIbwrGFM+0tvqFXp3kn4dPuvyVl7bAcO5CMg8AHWtZNENU/M8QBb1xNt6NsHVmtOK3mKEyutLCu5PR3A8OeEYu0AG+pMAo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by GVXPR04MB9927.eurprd04.prod.outlook.com (2603:10a6:150:118::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Mon, 12 Jun
 2023 16:14:57 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 16:14:57 +0000
Date:   Mon, 12 Jun 2023 12:14:45 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     lpieralisi@kernel.org, allenbh@gmail.com, bhelgaas@google.com,
        dave.jiang@intel.com, helgaas@kernel.org, imx@lists.linux.dev,
        jdmason@kudzu.us, kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH 1/1] PCI: endpoint: pci-epf-vntb: fix typo span in
 comments
Message-ID: <ZIdEdQAgdqLNsxpU@lizhi-Precision-Tower-5810>
References: <20221214172254.668282-1-Frank.Li@nxp.com>
 <20230408093644.GG11124@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230408093644.GG11124@thinkpad>
X-ClientProxiedBy: SJ0PR13CA0150.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::35) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|GVXPR04MB9927:EE_
X-MS-Office365-Filtering-Correlation-Id: 206505e0-e3c0-4512-a378-08db6b602a5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kkJyyzFxND+EsLA9RkCbCAdvW18yNrik0Q1OarFsNj3iSzG+Gczmh+k+3U+P1fLIiZXipfTErQ438RHzxLFgbWPXFl1XG899fhbJ26I6M4S76LwLEMCRnQqIfN61EvX2HF/ruKTKjZv+Abs++lRjhIjM9KV0rptoBajylM7X520wupGHlJCJWtNiWPAWWgz40xK18SpAFs3VWE7+Tnf/xoKVt9SmTjBv0dQYlv43EUoQJZ4ZplI1H1x854Q46F7xsImOx+wd83Yl1AruOO3XVf5HI71Qsa9sdoyOjTbzT5iM1TZvA30Ucg+uBVofOgdLVMIWmz9aDVAaRSyLFUaYY82eSZxaCUMA554s38xJgu8bNfwcZkSbR74wmUggt00k/S1zgs4CXG+FxqybAEgkttujBtJHXu6EsMP7Xy8T0booXChjhyEA+qXB+JNfPBHJ57KcLCnVXXGDSye7gmDI63k2UcYD7cUeAoc5OXQ9nKeNuU81JWisujGkokEH9KV4PiPrqlDjyCapg9VSCX5TpFPUXsF2MsGvxnKUZM8gxndff+buHf9szD2wyhWhRoq8RGk0KYDa8zxlB1xcPkBnFAjoF6dzU3ffxzDt7YTpecs03p1u8xeq8SScybc+xHI5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199021)(83380400001)(86362001)(38100700002)(38350700002)(33716001)(478600001)(4326008)(6486002)(6666004)(8936002)(8676002)(2906002)(52116002)(5660300002)(7416002)(66556008)(66946007)(66476007)(6916009)(41300700001)(316002)(186003)(6506007)(6512007)(9686003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z004NVkwU2xDSGYwVkZOeWI4RjJ0UDBOZVVGOHhQMFdicHhseU9vMTBYN0Q4?=
 =?utf-8?B?NGJnd0JZUzRaQVFZU1dmeEJzaTJ2VVkzYVAwMEZ1T2hmamY4YWRIWGRsTzdw?=
 =?utf-8?B?bnRLZ0NUUTU0dDRSMlVFQ201SDQ5NW5iOFg5RlZhNHhnNEU3eTdDdk1HVldN?=
 =?utf-8?B?UFdLSDdERHA1M0pnZmxQL1VQNTF5aVFjNnI1NWRrV0x3emxGUXh0Ukp5TW5B?=
 =?utf-8?B?a1oxK1g2b0NQd0NZSnFMSzlYU1VWcTFjZi9KZG84aktybXJ2cms0cnhldU9X?=
 =?utf-8?B?eUJROHlOVlFadnZVL1R6ZGo4WGZ4T3lUZ3VhSWREMytBUnlzQ3ZUTXkrQ1FV?=
 =?utf-8?B?TVQ1Si9VNlUxNUMvMnNxNDJZaVR1dEUvK25vbHViZXhjbTFsVUVhczNCbzdy?=
 =?utf-8?B?YXhBZXl5elh3UWNsT3lMeklXMDFpY0l6Z1FybXkwS2NqcS9Nd1N0dXM5N3ov?=
 =?utf-8?B?TnpjM1RmTmdyM24rMVFQZjV6M004aWtCVFpTR2RKRUdDWDRhaUprVHhiaWlT?=
 =?utf-8?B?K0c2aCtkZW5xcld2bXFucjdaM1cvL2pZK2lOUVZXWGVodUFoN0tQWDBuQkFM?=
 =?utf-8?B?KzdMYUdDRUhBQ0oxeWljM0pRUFpHNFZ2K1Aybm9SQkpwbW9OamNiZFRRWUQr?=
 =?utf-8?B?THFnaE01WkJ4bWdEbGM3UkFFOTZjTDl0c25LYmFybEgzU2xPMnlPRWVWVnIz?=
 =?utf-8?B?Vkk5dCtHTGNCUUR6RTV3Y05OTjNjb2lBNlJ1TWxPbXRzM1BleXMraEQxVjZr?=
 =?utf-8?B?VEY0U0NONjJWRGJ2THdnYVZNMmNWckFGekkzZFZGdW1ZUjBKNDFJajAvT0hr?=
 =?utf-8?B?QmpCNm84NStNR0VqWUw2WmhTeEVDZE1BLzJKbmxsQ2NoaFovL1g5b1JTdGx3?=
 =?utf-8?B?WDljNjVQQ0RITlR4QnJKazZLRGZiNUprR2lxT3FZY2dMVkdmRFgvZGc5UEZl?=
 =?utf-8?B?cmFjVGVJWGVHclh6ZHFvMWZxeVJ1TnZCN29lNGE0NFJqYjVoVDVBQXo4RE00?=
 =?utf-8?B?YjJpR21lYnpFMldjVkRoREhuWEZmV2JEeHZnUFNHSGpHOFZ3TWVvc0VrQ1JO?=
 =?utf-8?B?RVl6K0NUdWpyaWJHYWdYZGtWUFF1Z1Q1YzBrVEJvSDA1UlpkVkhDUzdIVkhv?=
 =?utf-8?B?OC9BdlFEZWlOZGhtUWpDNWNqWXAydy9nUnNjUG1wTFhkZWk4WjMrQ2ljV3A4?=
 =?utf-8?B?TGIyUFZqUEpVWXBnVGdtRkxJNnpObmhxbndPd0o5cS9sOWtjT3ZoUnE4Q2hJ?=
 =?utf-8?B?WlNUQzZmcUIwdURxeCthSTVTeUNVMFkzTmI0dVlLcWowY3ZtWmdUQ2I3YzJs?=
 =?utf-8?B?R3diVkpwaGtHR0FFckI4UmhtdStTS2dtdG1xNW13dkVaN2F3cnhZUjJPMWI1?=
 =?utf-8?B?RGczZ2JVSFZrM29SU1JUVEVUZUx6TG9CWVBvYzFxdmF3VU1zTVF6VFRNcnR3?=
 =?utf-8?B?eDFrYmlNeSt6VS8wL2xOU3h4aTh1ZUl0Y3BBZGpUVVB4dU91Sk0xbEg2bjk0?=
 =?utf-8?B?Qy9PSlppS0hNaFVGMmFvZlB1SE9NRjJFSjJnUmFmRHF3VGVyMmdXeE15YVdt?=
 =?utf-8?B?OU1lZHVZeGxkTndicnhWUkRGUEk1bGN4RHZQT1RlbkJ2KzV6ZGN6Yy9CcmNj?=
 =?utf-8?B?WUtHdkJLRHhzMHJnMldMTUE5bkpGN1RPTmg2MDFHUlZxdFJNdW9kZzYxcW1Q?=
 =?utf-8?B?S2hMN3JqOUhEamw5RGhqcGhOZjBVemZsRFpVcEdLZUMzOHdDK2JHMXV5cGVm?=
 =?utf-8?B?QloxSitnN3F4SmJlTDhnOVNsLzVDejc1VGpOWDJERVVpd3I3dTJ5L2ZZMlpk?=
 =?utf-8?B?eFVNS1daME44WVZvMlR5WXB5SnVpcENkUmlMMFIwUG5IbEdqNlJQS0IyR2xa?=
 =?utf-8?B?QmNZZXhqQXdjM0gyVXZ0WTI3cDZ4QkhjYy93RmNwb0hLNXIxcXNXTFRmVWhs?=
 =?utf-8?B?T0x1UVcraFZDRkNwdlpkbTlCbldXVm9IODRoSWtYaUU2anRxaG5xZUVjRjJG?=
 =?utf-8?B?WGdPSjRqSUM4YVFDV2lUUXZkRW41RXp4WHp1bitWeE50WUlsVnVBcE1zWm9X?=
 =?utf-8?B?Z0pkTThvd2xZNkVBc1JKdjFwaDFJNm14UWFWK0tURWtMdndXczUxU2hzU3pH?=
 =?utf-8?Q?MnRMyzm4YUAiNTMR3M4459H0N?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 206505e0-e3c0-4512-a378-08db6b602a5c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 16:14:57.5862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LT5lRuxRk4b3NkVDW3N9f23XthaccLz4tD+F/l0BbFhJqrsbND30pvP6adUWhUdsULPcl56exRy7knc2bjv6yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9927
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 08, 2023 at 03:06:44PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Dec 14, 2022 at 12:22:54PM -0500, Frank Li wrote:
> > Replace span with spad.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Ping, just fixed comments

> 
> - Mani
> 
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index 58a23ef4b572..935748244078 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -84,15 +84,15 @@ enum epf_ntb_bar {
> >   * |                                                  |
> >   * |                                                  |
> >   * |                                                  |
> > - * +-----------------------+--------------------------+ Base+span_offset
> > + * +-----------------------+--------------------------+ Base+spad_offset
> >   * |                       |                          |
> > - * |    Peer Span Space    |    Span Space            |
> > + * |    Peer Spad Space    |    Spad Space            |
> >   * |                       |                          |
> >   * |                       |                          |
> > - * +-----------------------+--------------------------+ Base+span_offset
> > - * |                       |                          |     +span_count * 4
> > + * +-----------------------+--------------------------+ Base+spad_offset
> > + * |                       |                          |     +spad_count * 4
> >   * |                       |                          |
> > - * |     Span Space        |   Peer Span Space        |
> > + * |     Spad Space        |   Peer Spad Space        |
> >   * |                       |                          |
> >   * +-----------------------+--------------------------+
> >   *       Virtual PCI             PCIe Endpoint
> > -- 
> > 2.34.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
