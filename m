Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD87604D50
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 18:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiJSQ0C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 12:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiJSQ0A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 12:26:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F76518F0C9;
        Wed, 19 Oct 2022 09:25:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F41F06195C;
        Wed, 19 Oct 2022 16:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F56C433D7;
        Wed, 19 Oct 2022 16:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666196758;
        bh=0bQZmrlbRpZ9ws+WGy2M+UgT6k1lZNfVBuaSFzLXw34=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bgKBhraCjC02RBHGDBxVDk0T2QrFrwdkGvIJjEwnDcjqAQ6L/IZOn0PGaEjhJ3De1
         wEYu9+peZyhs/Z09c/sptBwGV4MpcwLBVNBJT6I5t448bc/nVSBeaxUDE43qViiceN
         AhfTwm6u3aXJwn5e6S38/u48wVLaIQA6FisX0OrtI1eyI43l7t8ZGHaDwASHkLsXIK
         PioWvdTw7YINsp72XRHIFfYSho3PqeEAFtGKvUCGICKA0hK9FN8WQq/CJpIKt9awGu
         04Iro2lETydQt1dDAH4VLMsXzc1PbLxLd9w2wxiHgklGObhoQBcdNz5+9Y80KFl5no
         1Qmv3U9ZdyYnA==
Date:   Wed, 19 Oct 2022 11:25:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     imx@lists.linux.dev, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:NTB DRIVER CORE" <ntb@lists.linux.dev>,
        "open list:PCI ENDPOINT SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13 1/6] PCI: endpoint: pci-epf-vntb: Clean up kernel_doc
 warning
Message-ID: <20221019162556.GA20373@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221007191326.193079-3-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 07, 2022 at 03:13:21PM -0400, Frank Li wrote:
> From: Frank Li <frank.li@nxp.com>
> 
> Cleanup warning found by scripts/kernel-doc
> Consolidate term
>     host, host1 to HOST
>     vhost, vHost, Vhost, VHOST2 to VHOST

When you post a series of several patches, it's nice if you include a
[0/n] cover letter to tie them all together.  Regrettably, this is not
very well covered in the documentation, but here's a pointer:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/5.Posting.rst?id=v6.0#n334

And if you look at the archives, you'll see lots of examples:

  https://lore.kernel.org/linux-pci/
