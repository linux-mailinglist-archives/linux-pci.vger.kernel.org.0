Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFF1193E9B
	for <lists+linux-pci@lfdr.de>; Thu, 26 Mar 2020 13:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgCZMGx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Mar 2020 08:06:53 -0400
Received: from ozlabs.org ([203.11.71.1]:37829 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728296AbgCZMGw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Mar 2020 08:06:52 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48p3cp1sr7z9sSb; Thu, 26 Mar 2020 23:06:49 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9475af081ec1fb6cc794a17ae90f2c01aa8a7993
In-Reply-To: <20200312140412.32373-1-chenzhou10@huawei.com>
To:     Chen Zhou <chenzhou10@huawei.com>, <paulus@samba.org>,
        <tyreld@linux.ibm.com>, <bhelgaas@google.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     chenzhou10@huawei.com, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PCI: rpaphp: remove set but not used variable 'value'
Message-Id: <48p3cp1sr7z9sSb@ozlabs.org>
Date:   Thu, 26 Mar 2020 23:06:49 +1100 (AEDT)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2020-03-12 at 14:04:12 UTC, Chen Zhou wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/pci/hotplug/rpaphp_core.c: In function is_php_type:
> drivers/pci/hotplug/rpaphp_core.c:291:16: warning:
> 	variable value set but not used [-Wunused-but-set-variable]
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9475af081ec1fb6cc794a17ae90f2c01aa8a7993

cheers
