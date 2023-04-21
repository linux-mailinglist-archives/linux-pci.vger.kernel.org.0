Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35446EA5D7
	for <lists+linux-pci@lfdr.de>; Fri, 21 Apr 2023 10:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjDUI33 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Apr 2023 04:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDUI32 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Apr 2023 04:29:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBB1137
        for <linux-pci@vger.kernel.org>; Fri, 21 Apr 2023 01:29:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CB4664E38
        for <linux-pci@vger.kernel.org>; Fri, 21 Apr 2023 08:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418B1C433EF;
        Fri, 21 Apr 2023 08:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682065766;
        bh=c+3L3STe30fmERWtd72rIPDVbF5FjuCzRSycCJhHOBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M2Hyz3gK/JZNs44RMMOspMqXqac/QlttsFqr7SS+cajLcKpOVO8CoqKXIMuLv264z
         oSZBEyZ8H2qXy/0tfAEpd9EpFOoLiLYic/VBztqcifpbaXZKHvN1lqz+ngS7AfOZxv
         jYI2J4E9Cj5gqL2HPXLqgO0mKSCawTTvOAmw5BlPBl8R3H4vNHQecuFs4KuAWlRN5J
         nAeQbFqjE2fxkfdX8zofGiprecmYbKvLlKiCMtIM+MXc/8YRemfmCysowT/2qYloxz
         8loKV9tlISK0AUP+aT/XDo1Rd5kyDzME8vvnJCveF9Z0U3KE4v9dWlsJ1nq8Efptpc
         YY586gKJaMRWw==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     linux-pci@vger.kernel.org,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Nirmal Patel <nirmal.patel@linux.intel.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH] PCI: vmd: Reset VMD config register between soft reboots
Date:   Fri, 21 Apr 2023 10:29:21 +0200
Message-Id: <168206574205.75321.15839064349849384405.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230224202811.644370-1-nirmal.patel@linux.intel.com>
References: <20230224202811.644370-1-nirmal.patel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 24 Feb 2023 13:28:11 -0700, Nirmal Patel wrote:
> VMD driver can disable or enable MSI remapping by changing
> VMCONFIG_MSI_REMAP register. This register needs to be set to the
> default value during soft reboots. Drives failed to enumerate
> when Windows boots after performing a soft reboot from Linux.
> Windows doesn't support MSI remapping disable feature and stale
> register value hinders Windows VMD driver initialization process.
> Adding vmd_shutdown function to make sure to set the VMCONFIG
> register to the default value.
> 
> [...]

Applied to controller/vmd, thanks!

[1/1] PCI: vmd: Reset VMD config register between soft reboots
      https://git.kernel.org/pci/pci/c/e06720c1d9e1

Thanks,
Lorenzo
