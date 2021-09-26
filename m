Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42271418B00
	for <lists+linux-pci@lfdr.de>; Sun, 26 Sep 2021 22:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhIZUcz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Sep 2021 16:32:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229894AbhIZUcy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 26 Sep 2021 16:32:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 86FB960EE4;
        Sun, 26 Sep 2021 20:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632688278;
        bh=/Hozk0nopGOayKv1poFzF4SX10bl8yXGfpVd9ZMgpbw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oIfDfZ78BGVWE8VEN926yEFIgkl53MnJTumWTfaHOth2W5Q6dQM5Zge4ySu7Acxx2
         pz8ex/V3CFgkGWAfqJaBda6ImMOMkDkZzgFUbhJxI+xES9oRK1RvwKjwPAoFCxh3j+
         RsV+cr3r9+6Blu6CavEw5DQCis4sICzd4JgdmP5bULy2ZdcT1G2mKtStZAjuuuPZ07
         x7xGYc8XrPMmRiYJ3EPeSGFtU+QXOoNdxZsYGpWCzWROczQ0bohMCPAFWKOqKr+b2/
         QATnJPbvW3eRa+tBpZv3o3bNIGcoAnpwV+BIvSXaJjaharLaL5g75LOmcpec0OtP8T
         C9xCakQrHJoZQ==
Date:   Sun, 26 Sep 2021 15:31:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com
Subject: Re: [RFC PATCH 0/3 v2] PCI/ASPM: Remove struct aspm_latency
Message-ID: <20210926203115.GA590101@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916084926.32614-1-refactormyself@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 16, 2021 at 10:49:23AM +0200, Saheed O. Bolarinwa wrote:
> From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>
> 
> To validate and set link latency capability, `struct aspm_latency` and
> related members defined within `struct pcie_link_state` are used.
> However, since there are not many access to theses values, it is possible
> to directly access and compute these values.
> Doing this will also reduce the dependency on `struct pcie_link_state`.
> 
> The series removes `struct aspm_latency` and related members within 
> `struct pcie_link_state`. All latencies are now calculated when needed.
> 
> Changes in this version:
>  - directly access downstream by calling `pci_function_0()` instead of
>    used the `struct pcie_link_state`
> 
> Saheed O. Bolarinwa (3):
>   PCI/ASPM: Remove link latencies cached within struct pcie_link_state
>   PCI/ASPM: Remove struct pcie_link_state.acceptable
>   PCI/ASPM: Remove struct aspm_latency
> 
>  drivers/pci/pcie/aspm.c | 89 ++++++++++++++++++-----------------------
>  1 file changed, 38 insertions(+), 51 deletions(-)

Hi Saheed, what is this series based on?  The other series
(https://lore.kernel.org/r/20210916085206.2268-1-refactormyself@gmail.com)
aplies cleanly to my "main" branch (v5.15-rc2), but this one doesn't
apply either there or on top of the other.

Bjorn
