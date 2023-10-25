Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B018A7D69BE
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 13:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbjJYLFZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 07:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjJYLFX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 07:05:23 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636D110A;
        Wed, 25 Oct 2023 04:05:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNwxgffDj5eNNCxhGbdEpcXGOEBmBWcAwzj4lNEOVQoU08OnLFBHjyUNnxSH8Ds1FPggHw800kvZCmjHnGmpebYbOLclurSDNXZ9SF2XiICIjVqgNrd2XWwOcyRUvSUjGboOp33dRqm/R5dam2CqC5INqoSQtAO0Ejn6ZfZ7SdqMY7wKbDz4uLn65lgBa34gxw4SRfpsIQx1gq9jd1W6lH5/NEadjR3U8dhNif99Pgqm0vo7PeTDCSlBnYGberxTKGhj/z2WkylReAU1NDrTMsJtnd/L9aBEpInYr0xMOwV1/YiKK6uNBA5Ko1OKeZT1YF3Cy77934MeZlI52NV9Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JGf7IxgY6E4J85t+VDTpZNd5j4A4dN4lEtXXG3bVp0=;
 b=OjMhkNyXASIp0u7gf1wuQTDcfx0je8nxftuM/9SGb19W63fMk+Iccd7EuB7qM1gwwdU8li1w/3WfN8p18bmNGavXNvg/d/56uA6d3KDjcLGCAscd05rVVUJBStsukfxps+/hCki6dSVmHqs98NbCgXEVItP3QBpH8Fk3zQjlmqfloP685XBxKd9GY4VK+ObayHogEdvWOxP4JceRf1kIs3/pGn9XMWlOQTpR+ysH16q6NTeYn+h/pBVYW3hpAH/B76x5AC8XAfS2IgYbGOuKZh5rAeWLZQ60GKvVi2mXx4Uvk7tvW5qD6+lTV1TWkAOWX9ttQuw7jWXCxr7oundNpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JGf7IxgY6E4J85t+VDTpZNd5j4A4dN4lEtXXG3bVp0=;
 b=FW/hPWZ1nsZzlBQRdZf19hzucwCaD/WzGWPEM18yEe/kr40fWG8Yxt7VMisWoQ6NYGnGB6U0uhhOw2u6B/8qS/PIEHDK7rQ1uec0cmelCZtGxITtL4WmOiFlq4oQJfcg+ZU7jE6TPH1/A0XdxrcpJJNexN9JRLi/Rknbus79gPJTe9cg+NMteGtSdVlTxeCZ2Ralqq+vYOK5l5OqpZqtUDuBaFlcTjGAFbXbfEx/LCkf3Ff3xkcp7Z1poZwtZ9B49KbiqW19T/TvNRURcVOQ+FKV2BrSbvQlL4YVNTJmCcpMVVIKBsHAxypbqj2yXo9imW9h2EwRJ2lTjlHMlHw3Hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by DM4PR12MB5745.namprd12.prod.outlook.com (2603:10b6:8:5c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.19; Wed, 25 Oct 2023 11:05:16 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::6f24:e252:5c2f:d3c9]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::6f24:e252:5c2f:d3c9%7]) with mapi id 15.20.6907.030; Wed, 25 Oct 2023
 11:05:16 +0000
Date:   Wed, 25 Oct 2023 14:05:11 +0300
From:   Ido Schimmel <idosch@nvidia.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     netdev@vger.kernel.org, linux-pci@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, bhelgaas@google.com,
        alex.williamson@redhat.com, lukas@wunner.de, petrm@nvidia.com,
        jiri@nvidia.com, mlxsw@nvidia.com
Subject: Re: [RFC PATCH net-next 05/12] PCI: Add device-specific reset for
 NVIDIA Spectrum devices
Message-ID: <ZTj2Z5T53uJbV1Mq@shredder>
References: <20231017074257.3389177-6-idosch@nvidia.com>
 <20231018200826.GA1371652@bhelgaas>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231018200826.GA1371652@bhelgaas>
X-ClientProxiedBy: TLZP290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::19) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|DM4PR12MB5745:EE_
X-MS-Office365-Filtering-Correlation-Id: d251f635-d13e-4bb6-ae70-08dbd54a44ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uyxw0ahUCdJ/Q4KPvmbAhrTCwljoKHX+CGTqCU4fA57KvpVGL8j2PsUfHbEgH9vuj46a9k48Ob+Pvw/LV/6lwL7qucIq+1VjzQuZLrERN/56Df5cbjFnguG8KTRsiZabXEtKoQoJn45/Sj46bbFKME2/RigRZTKwIcBcD6bRQA1zHxZR2UfSV9LOrvCn+dsEMYNgsFb0ijWD9QYT9QgqT8AkSKS+o7zI2ygwGe/drpnBY/dzjtUQ1LKZyzZR2yhYRiOJRXAd3OtkhK3THBbLCYkGyHV2GM3WQWW0vdsQKbdybu8p8QU99Gtn5sicL5G099Ku7Tw4IcS+L+uiD6vYzPTLFQZijvjhBLjcYLcpUxgZ0SPNNZ/bJb2/E18iI+5CJWUzre/K0OpC+It+xyul6ymHEmBnGJkdm/92zHfw2KX3kk3bMCLr8akRgIH+ACL/JmCriyIDPxWipbal7AeqQb7uVP+sIQWqUCAeSVlcwHSIkUCqnns/BiP3fkC8iiZz6tnhS4E0kazuvXp4mOZ3lzScAUrincP4IaeLE/6zswAE+aEnCnqFvsEAb9TirzP2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(376002)(346002)(136003)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(41300700001)(6506007)(6666004)(478600001)(107886003)(9686003)(6512007)(66556008)(66476007)(66946007)(6916009)(316002)(86362001)(6486002)(33716001)(26005)(83380400001)(38100700002)(8676002)(8936002)(4326008)(7416002)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmcrYjBFYXZld0cySW1FWEw5bHZjN3NNWmlQVzQzWjJINmZjRkVPU0hxQ3Z2?=
 =?utf-8?B?NmRUNXdlWk9JMkhlVGxQM1EzOTEvQnNnRm1CWmhrZ01keXBsNUp1ZlB4YjFU?=
 =?utf-8?B?NjlIQXFzRXVqUU9xemlKRjNISE5pK0VmdXRrbWxUQ2hKVW56cnV4SUZlcDJq?=
 =?utf-8?B?cVhWZy94ejlRcTZyNUl0SmREdXVJaVdVMS94TEQwc0VoQ29SMExISjJkTDV5?=
 =?utf-8?B?ZndLYnprNEVOWnQ3YVo2MkY5TUFzbmxYa21ZNzBwL0xuZGgrYlE1L2JWRCtI?=
 =?utf-8?B?ZHpjR010WWVudWpCbFdXdFgzWDFxNit6Mjl5cnpYbUU2bThLQ0wwTkxmN0tO?=
 =?utf-8?B?UUJvTUhCbjVMeEdsRWpiT0ZZTXFBcnhZUlVZQkxOZnBwci80OU1rZVpaWnJB?=
 =?utf-8?B?cXFuc0xXMXpvSW9hQ3RqTjVkY3M1Qit6YWpya0Y0MXl5Rmw3UVBkMUNZUFI1?=
 =?utf-8?B?MnJKTG1jQ0xQRTh3QnVlcmd4ZCsvTk5wU1VxMTI3VWpzaEdNT24vK1NNands?=
 =?utf-8?B?RDZ3ODFhSnhjWHRZR3Z6OE4rR3lrdUs0NmVzLzZJMkt4Zm9DeGpBY1JRT1VB?=
 =?utf-8?B?QTYyU2hlUEdqNGZxOFdaK1lzK1oyeERFVnZORmYrQjFQMHN5Tzd4eCtTTDRK?=
 =?utf-8?B?enlHU1BGOVFETG1adDVsM1AxeUxXT2FDREVWdTlYTngzb2VZbzI1aU85TitX?=
 =?utf-8?B?VXhMT1U0NHBuamh6T24yZjN2VzFSV0ZuWmRlSVVnWTBmUzkxYlVGejZSVlh5?=
 =?utf-8?B?UjVWRlZWZTVybCs2MFpDMERoRUpzaUlnTjRyMTE4b29uaTJzUVRaWm43RlBZ?=
 =?utf-8?B?S0dLaHlRaFA0NGJENVRrRTNHR2RnUTFzeWV4bkg5RmFOaThTVEhmZUt6K1JI?=
 =?utf-8?B?N2lCK1R6eW54amdTdU9jaURrZTlteEhtQm1zZTY2TWJXdGxScEJvOEtzVWVO?=
 =?utf-8?B?YjBQY1hsblc1TUswV2pUWC9ocnlZVlNLU2lSRXQ0WkVmbnQ4YU4vKzdqSmdj?=
 =?utf-8?B?UHdZdkRHVU5lV0JGWlNzbXFWblYxSUFheDkwc01nUFBGdElHT2lMRlpod3Zv?=
 =?utf-8?B?MUcralllUGg3N1I2Qy9rWkpxcVBqQ1NvMGFqNkpVclFreXFpVXkxTVNXMnhk?=
 =?utf-8?B?dVp0MGdXRmtSTFJ4OG82OHpGNzlacDNYbkFUeXhwbkdTV3g4YlZBRmlhK25I?=
 =?utf-8?B?UWtaRnZDYnk1Rjh0QSt2Wk11QXFMNUJCVnlOL1krZmFKVktMVGlBVE1kTmZy?=
 =?utf-8?B?SXFhN1A4SkpXNWdJeGorcVlieUFRNVAwMVRvVHpPSWYvNWlZazQ5cnJQOTY1?=
 =?utf-8?B?UGlPVGhMYldFRGVLTnpNQWo5MTZjK2JRenZrMTZseXA2SjJqNHBnZGN4b1M5?=
 =?utf-8?B?Ym1FSlRoTlFnbTU3c245NXpZODgxaUlEVFBFejZYeEROL1VwdVlxYktDZjds?=
 =?utf-8?B?dkJKU1ZUSUJwMHVScnpTQnUwUEtKYWdiNjhWNC9WN1hBWDBUcnRpRlhCL3k0?=
 =?utf-8?B?WVZSTWgxY1NiYUx2VnkxaUVKRXlSL3hZVjlLTmIrajBEY21yQXViY3VJMGwr?=
 =?utf-8?B?SjRIUXdsRzhFenBuVWlYRVdaQStSRllQQ2pOZjc4ZkREdXJ2TmpJSnhJc2U4?=
 =?utf-8?B?NFViUi95VWVRK3dXZU50aXNnRkFsQ2tIZDJBaEN6ajRNQVNFMW1oMHQxeVUw?=
 =?utf-8?B?R3MxVkhxSStnT3FXemZZR2dudW5jNjVOa3NjWEJsQ3d0b1drcmd1VHV5OHFK?=
 =?utf-8?B?NmZ3VTZDNVpObDhpNHhvd0N6NSsyMDVsQlVFL1ZHUko2UHJXZEdQZ3JXU3dr?=
 =?utf-8?B?S3pLWUpzbEFEbUg4VkRTRzRBUU9VKy9JNUg0K3k5ckN6a2MrUFdGc1hIbWlO?=
 =?utf-8?B?bWFCeDlrR28rZXJWdldEREg0MjNNek5ESThXNVNwd05xcEhGbWVPSDFCLytH?=
 =?utf-8?B?eXNBVUFBM2wvMVI0MlA2TVRpK2xkaVdUVTBqT2laVGFHL2JkRjBaNzJZZzJ4?=
 =?utf-8?B?R2srYWxOZ01UNlVDMjhiZ2s4QS94enljeHFNWm5KOU90OURyYTd1YnkyY0Fv?=
 =?utf-8?B?YVBBaXFvWDNsMDRoaUtUU3dFUVdRS3RremRpenpxRG8zVTJ6MlhSUDl5amRM?=
 =?utf-8?Q?o40ZXBtFQQ4zzYnuG978zG6ts?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d251f635-d13e-4bb6-ae70-08dbd54a44ff
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 11:05:16.6465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PlE6QOxJViQcBoyyeB2mu3bmQQ83FDr5F9XeRyaQLvUCoOgNtdjCKGwCL6h6ol3aG2bjdhPStuVudXgkB/x4lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5745
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 18, 2023 at 03:08:26PM -0500, Bjorn Helgaas wrote:
> On Tue, Oct 17, 2023 at 10:42:50AM +0300, Ido Schimmel wrote:
> > The PCIe specification defines two methods to trigger a hot reset across
> > a link: Bus reset and link disablement (r6.0.1, sec 7.1, sec 6.6.1). In
> > the first method, the Secondary Bus Reset (SBR) bit in the Bridge
> > Control Register of the Downstream Port is asserted for at least 1ms
> > (r6.0.1, sec 7.5.1.3.13). In the second method, the Link Disable bit in
> > the Link Control Register of the Downstream Port is asserted and then
> > cleared to disable and enable the link (r6.0.1, sec 7.5.3.7).
> > 
> > While the two methods are identical from the perspective of the
> > Downstream device, they are different as far as the host is concerned.
> > In the first method, the Link Training and Status State Machine (LTSSM)
> > of the Downstream Port is expected to be in the Hot Reset state as long
> > as the SBR bit is asserted. In the second method, the LTSSM of the
> > Downstream Port is expected to be in the Disabled state as long as the
> > Link Disable bit is asserted.
> > 
> > This above difference is of importance because the specification
> > requires the LTTSM to exit from the Hot Reset state to the Detect state
> > within a 2ms timeout (r6.0.1, sec 4.2.7.11).
> 
> I don't read 4.2.7.11 quite that way.  Here's the text (from r6.0):
> 
>   • Lanes that were directed by a higher Layer to initiate Hot
>     Reset:
> 
>     ◦ All Lanes in the configured Link transmit TS1 Ordered Sets
>       with the Hot Reset bit asserted and the configured Link and
>       Lane numbers.
> 
>     ◦ If two consecutive TS1 Ordered Sets are received on any
>       Lane with the Hot Reset bit asserted and configured Link
>       and Lane numbers, then:
> 
>       ▪ LinkUp = 0b (False)
> 
>       ▪ If no higher Layer is directing the Physical Layer to
>         remain in Hot Reset, the next state is Detect
> 
>       ▪ Otherwise, all Lanes in the configured Link continue to
> 	transmit TS1 Ordered Sets with the Hot Reset bit asserted
> 	and the configured Link and Lane numbers.
> 
>     ◦ Otherwise, after a 2 ms timeout next state is Detect.
> 
> I assume that SBR being set constitutes a "higher Layer directing the
> Physical Layer to remain in Hot Reset," so I would read this as saying
> the LTSSM stays in Hot Reset as long as SBR is set.  Then, *after* a
> 2 ms timeout (not *within* 2 ms), the next state is Detect.
> 
> > NVIDIA Spectrum devices cannot guarantee it and a host enforcing
> > such a behavior might fail to communicate with the device after
> > issuing a Secondary Bus Reset.
> 
> I don't quite follow this.  What behavior is the host enforcing here?
> I guess you're doing an SBR, and the Spectrum device doesn't respond
> as expected afterwards?
> 
> It looks like pci_reset_secondary_bus() asserts SBR for at least
> 2 ms.  Then pci_bridge_wait_for_secondary_bus() should wait before
> accessing the device, but maybe we don't wait long enough?
> 
> I guess this ends up back at d3cold_delay as suggested by Lukas.

I had a meeting with the PCI team before submitting this patch where I
stated that bus reset works fine (tested over 500 iterations) on the
hosts I have access to. They said that bus reset and link toggling are
identical from the perspective of the downstream device, but that in the
past they saw hosts that fail bus reset because of the time it takes the
downstream device to reach the Detect state. This was with a different
line of products that share the same PCI IP as Spectrum.

Given that I'm unable to reproduce this problem with Spectrum and that
your preference seems to be to reuse bus reset (or bus reset plus the
d3cold_delay quirk), I'll drop this patch for now. We can revisit this
patch in the future, if the problem manifests itself.

Regarding the other two PCI patches, I plan to submit this series after
net-next opens for v6.8. Are you OK with them being merged via net-next?

Thanks
