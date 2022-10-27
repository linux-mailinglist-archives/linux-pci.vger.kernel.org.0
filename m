Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A823C60F9F8
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 16:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbiJ0OCZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 10:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbiJ0OCX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 10:02:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16358186D57;
        Thu, 27 Oct 2022 07:02:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A93A36233C;
        Thu, 27 Oct 2022 14:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E819BC433D6;
        Thu, 27 Oct 2022 14:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666879341;
        bh=0/4yusk0lO2Onca3PjpwGX9M8VMhQMWRLSSTO2BwRVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WXVOsrljuSZ8Shu5+xry14AtocOZWO8ahx/Z4ddmNHv4+s8NTUHdQ3m0tYGK9UMzR
         VYb59yP7T6rV35uVuF9RGQpvompKT6/G8tM9rEr1qYIrhN3wWVKguM+aU1XlLINhIW
         MPo8yMVe2HrqG91Luko4a4eJpc7f0Lpzny26ks2CXcb+6yEoEW0qVGQmHuqV1+voFI
         gdSuA3Ro1XY1jVkuPjN4mnk6ryNceymr0dAphANq6ydFAAKqGhn7Ge7EWSnONdiJ7q
         IycYaLSgNcos/oLKQWmYwIy5h5J6GQVhDgh21DJ7rMoIHoZn7ZJPKIlagk41ee4dIP
         28bZBk0WcW+Ig==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vidya Sagar <vidyas@nvidia.com>,
        Om Prakash Singh <omp@nvidia.com>
Subject: Re: [PATCH v3] PCI: pci-epf-test: Register notifier if only core_init_notifier is enabled
Date:   Thu, 27 Oct 2022 16:02:14 +0200
Message-Id: <166687930904.849839.16614649919631091163.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220825090101.20474-1-hayashi.kunihiko@socionext.com>
References: <20220825090101.20474-1-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 25 Aug 2022 18:01:01 +0900, Kunihiko Hayashi wrote:
> Need to register pci_epf_test_notifier function event if only
> core_init_notifier is enabled.
> 
> 

Applied to pci/misc, thanks!

[1/1] PCI: pci-epf-test: Register notifier if only core_init_notifier is enabled
      https://git.kernel.org/lpieralisi/pci/c/6acd25cc98ce

Thanks,
Lorenzo
