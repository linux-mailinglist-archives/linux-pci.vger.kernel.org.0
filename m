Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8685E57D469
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 21:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiGUTyi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 15:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGUTyh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 15:54:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12603691D1;
        Thu, 21 Jul 2022 12:54:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFA9962098;
        Thu, 21 Jul 2022 19:54:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFF2C3411E;
        Thu, 21 Jul 2022 19:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658433276;
        bh=n0LUlDFRxvmloJIBnwb8oeIMcuhkLDWUpN3AnMOXSBc=;
        h=Date:From:To:Cc:Subject:From;
        b=Ck1VZV+5yea8vUj67fFZ9L0rykyv+jIoTeseyZpFa6kZX8n2AwKrluA1tOS5SKflr
         XHQioX4J3oNrA7V95QdX94vRktvDQ8OVFHx1futsGqK7LGkJcuKpYbx6nz8rgpPCxL
         PvupmD7f91D/gV75ItpLurZIiJKc1K299XiVWGyT0EXg7LIySe2ZJAmKtdzHUCCfmU
         s8kfGArkQx1o42KpRag8sm0RH8uFaUDVKIMG3ypX4zbALi6Nwh841ByuJPqr+ksbAL
         HB84rn13wW6/5vENx//kM2iznBU6oJI4ZCpO2dycg0nxNoTES8lDPHFZWP/g26jTYs
         ZaTPpFL20KSTw==
Date:   Thu, 21 Jul 2022 14:54:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     linux-pci@vger.kernel.org, Tom Joseph <tjoseph@cadence.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Why set .suppress_bind_attrs even though .remove() implemented?
Message-ID: <20220721195433.GA1747571@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The j721e, kirin, tegra, and mediatek drivers all implement .remove().

They also set ".suppress_bind_attrs = true".  I think this means
bus_add_driver() will not create the "bind" and "unbind" sysfs
attributes for the driver that would allow users to users to manually
attach and detach devices from it.

Is there a reason for this, or should these drivers stop setting
.suppress_bind_attrs?

For example, Pali and Ley Foon *did* stop setting .suppress_bind_attrs
when adding .remove() methods in these commits:

  0746ae1be121 ("PCI: mvebu: Add support for compiling driver as module")
  526a76991b7b ("PCI: aardvark: Implement driver 'remove' function and allow to build it as module")
  ec15c4d0d5d2 ("PCI: altera: Allow building as module")

Bjorn
