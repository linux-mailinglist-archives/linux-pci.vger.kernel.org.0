Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D834B055A
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 06:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbiBJFkz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 00:40:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbiBJFkj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 00:40:39 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A1410E9;
        Wed,  9 Feb 2022 21:40:21 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 2B1C910045BFA;
        Thu, 10 Feb 2022 06:40:19 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 07C4417FD1; Thu, 10 Feb 2022 06:40:19 +0100 (CET)
Date:   Thu, 10 Feb 2022 06:40:19 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Keith Busch <kbusch@kernel.org>, robh+dt@kernel.org,
        rafael.j.wysocki@intel.com, hch@lst.de, bhelgaas@google.com,
        mmaddireddy@nvidia.com, kthota@nvidia.com, sagar.tv@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Query related to shutting down NVMe during system suspend
Message-ID: <20220210054019.GA929@wunner.de>
References: <65b836cd-8d5d-b9c2-eb8f-2ee3ef46112b@nvidia.com>
 <20220209202639.GB1616420@dhcp-10-100-145-180.wdc.com>
 <0801d0ee-1c39-4413-7865-6c1c61e4706e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0801d0ee-1c39-4413-7865-6c1c61e4706e@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 10, 2022 at 09:41:04AM +0530, Vidya Sagar wrote:
> On 2/10/2022 1:56 AM, Keith Busch wrote:
> > Christoph prefers to append quirks for platforms that need full device
> > shutdown on s2idle instead of changing the driver default.
> > 
> > We use dmi matching for our current platform quirk list. I do not know
> > what the equivalent is for device-tree based platforms. Do you know?
> 
> I'm afraid I don't.

of_machine_is_compatible()
