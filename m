Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4386E7AA423
	for <lists+linux-pci@lfdr.de>; Fri, 22 Sep 2023 00:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbjIUWBU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Sep 2023 18:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjIUWA7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Sep 2023 18:00:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D98E70;
        Thu, 21 Sep 2023 14:58:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CB6C433C9;
        Thu, 21 Sep 2023 21:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695333504;
        bh=u7v5VLFGdrKsDLFjkZH8ifnNY0Exe13G/pmVjCMbpAI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oWGPFrm5CGC+MKz0xDYHT0yq9ZNihg2g/Nf5eYCS5vj9vDOQG89ZViIDmKx0fZfha
         2M3m7+RmVnzpLJeTfvc8d1WX12nlxvAiyu86NHH004F/L0XB4zIVq+lYDJZRizxzzj
         Kr/Sbdo90pe5T0+46PT9NSDiB3G1+o6SpFIz0GcZ7ntjYsDwCxRGmzth5GtzJHoUqr
         voEQirr9j/xlfNy+wHFowQb5jOhfWSe0DRbmltHB1cvVv2MTy2kXVNBAYVZxI4OqlJ
         yxnS6nnI9+lqvR6HLFC3wZUKdsWxh27T04nHnAi1T3MC4POc73clG4mynxGlixJnZc
         5ih0h0K1EHdjw==
Date:   Thu, 21 Sep 2023 16:58:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Cameron Williams <cang1@live.co.uk>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        sudipm.mukherjee@gmail.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/4] PCI: Add device IDs for Brainboxes/Intashield
 PX/UC/UP cards
Message-ID: <20230921215822.GA347672@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR02MB789950E64D808DB57E9D7312C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 21, 2023 at 10:09:16PM +0100, Cameron Williams wrote:
> Add device IDs for PCI/PCIe serial cards manufactured by
> Brainboxes (IS/IX/UC/UP/PX).
> Apologies if this file isn't strictly for your tree. All trees
> I am sending this patch series to use these PCI IDs, I was unsure
> if this was the correct way to go about it, and better safe than
> sorry. Thank you for understanding and please disregard if
> its not required.

From the top of the file:

 *      Do not add new entries to this file unless the definitions
 *      are shared between multiple drivers.

I can't tell whether that applies here since I haven't seen the other
patches.  If they're only used in one file, you can add the #define to
that file or use the bare hex values.  This reduces merge conflicts in
pci_ids.h when backporting things.

Also it looks like there's a mix of tab vs space indentation below.
They should all be tabs before the device ID and it looks like a
single space before the comment.

> +#define PCI_DEVICE_ID_INTASHIELD_UC246	0x0aa1 /* Revision 2*/
> +#define PCI_DEVICE_ID_INTASHIELD_UC246R3	0x0aa2	/* Revision 3 */

Comment indentation error.

> +#define PCI_DEVICE_ID_INTASHIELD_PX803R3	0x401e /* Revision 3 */
> +#define PCI_DEVICE_ID_INTASHIELD_PX475LPT   0x401f /* LPT port */

Indentation error.

