Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9ECC65DD97
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jan 2023 21:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbjADUWm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Jan 2023 15:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240236AbjADUWL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2023 15:22:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C7933D53
        for <linux-pci@vger.kernel.org>; Wed,  4 Jan 2023 12:22:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B15B6B818D7
        for <linux-pci@vger.kernel.org>; Wed,  4 Jan 2023 20:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340ECC433D2;
        Wed,  4 Jan 2023 20:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672863727;
        bh=QYbjgDAw4+s41UCk2w8TZRMHP928KMkudeP3nN7wQ0Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=egNUp2X3TgeY8sQRRAhKpOnI8XbW3tgVNjRgHW3Qi00fcUUCM8S4YCL9AJNByM5KP
         OJH+2LnKYPCn/uoAB1ufJrV4Kzmv3uNr3qiUTf/3z9SKMRwBJAPEYitqn3nkOdTHYU
         hxAq6Ioc0Kg3cJDWeOBW7etvwUqynjvFVn3MxrKGLIvfjqfAMIDj7jvHVrAiDkSasm
         EPKdcmQwqXYXCqlWm7z0eee2y5wwyo9lwutGCnVr3kWvlTdonqinrshlt32mKvICKq
         /jf7HR05sqwwAE51EFdYdJM+qBttevZKGyHqh8FlI5d2Fb02Gpco8J5K0XF+J+ujvz
         WURHudoU8knXA==
Date:   Wed, 4 Jan 2023 14:22:05 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [lpieralisi-pci:pci/switchtec 2/2]
 drivers/pci/switch/switchtec.c:623:1: warning: label 'out' defined but not
 used
Message-ID: <20230104202205.GA1091023@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301050315.6zwukcVQ-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 05, 2023 at 03:52:10AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/switchtec
> head:   fbc855bce49eda88408c329d6b2bc1176ab08dcd
> commit: fbc855bce49eda88408c329d6b2bc1176ab08dcd [2/2] PCI: switchtec: Return -EFAULT for copy_to_user() errors

>    drivers/pci/switch/switchtec.c: In function 'switchtec_dev_read':
> >> drivers/pci/switch/switchtec.c:623:1: warning: label 'out' defined but not used [-Wunused-label]
>      623 | out:
>          | ^~~

Lorenzo, I'll send you a v3 to fix this.
