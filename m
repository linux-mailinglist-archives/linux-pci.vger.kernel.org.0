Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C3C664417
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 16:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbjAJPG7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 10:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238860AbjAJPGT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 10:06:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE7A5F91C;
        Tue, 10 Jan 2023 07:05:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65E7661573;
        Tue, 10 Jan 2023 15:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA7BC433F2;
        Tue, 10 Jan 2023 15:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673363111;
        bh=8Td9q22Uw5o5QUURFz8ORkMMdOHQnIl4dgH2R27TkFw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Z1eoCebChzgQJb9VnsEp0gkpPIitdtY2RVz8w6GoLLOQdlozZ4JYefEFvpbafiFH+
         vQ9Qm6o6MPat1cK4uno3apCjcO7osOsSWfVZRYA4xst31X1VJUPmPCp52MQ7rQd27n
         UxX/exDBj4noWr5Dc+8aBvlFyZ3blQZ0aNpUdb22098clXxuCuVcF24FptBpLPGnx0
         kVxxh/nCWFpa6gk7KQFMnAgUgIG7QEYaQLoGbnbSMC3wGMefEtqpBmad4r832QPxtw
         uzJXX5agRrwN6P9RDlP5QnVknuA1YJUMXDcHwrTERg+b/uZ8y3pwuKtfAEXKQd9wXw
         VxmVtvIikirHQ==
Date:   Tue, 10 Jan 2023 09:05:10 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        jonathan.cameron@huawei.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, linux-pci@vger.kernel.org,
        prime.zeng@huawei.com, linuxarm@huawei.com,
        Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH v2 1/2] hwtracing: hisi_ptt: Only add the supported
 devices to the filters list
Message-ID: <20230110150510.GA1502847@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110130833.53474-1-yangyicong@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 10, 2023 at 09:08:32PM +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> The PTT device can only support the devices on the same PCIe core,
> within BDF range [lower_bdf, upper_bdf]. It's not correct to assume
> the devices on the root bus are from the same PCIe core, there are
> cases that root ports from different PCIe core are sharing the same
> bus. So add the checking when initialize the filters list.

"So check when initializing the filters list."
