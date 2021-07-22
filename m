Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0693D2CD8
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 21:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhGVSy4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 14:54:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229710AbhGVSy4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 14:54:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76DC460EB2;
        Thu, 22 Jul 2021 19:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626982530;
        bh=mc5Uo9yzRZneZyeHTHaPHC6UUh7w7hrfqWVSlfsgB0I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Vv84SXIYu//qgfmjl1PzrrDYbl+MVAdnE/4zK80D5iwjLFRcAz3gKhrD9oK1n1nFj
         vfoGnIRJdhkAuERWbyCXy9ckqS5pwontH5vcQUUqzq+BMk7vEQ7SVC/2KV/5jViBBY
         Aiz/nyEHXuzR5JtccPqHgVi8kmjfqnHnNi33Y4tLrkgGVaVs24Etb67DDcU3vuH7bY
         vMoaD/5NJqVyslSsao+xHsEr/ea3YWTMQS5IIh+lyfSIRNYazadzAPwLXmcdNPes/9
         kBohXkZjpBFxW/8fh1HttGaPshshHzDk8Wujcgy0Qg5gtRmQZUkcyf+Cj1Fpg/oZu/
         kNLH3/oI5u0gg==
Date:   Thu, 22 Jul 2021 14:35:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [pci:review/vga] BUILD SUCCESS WITH WARNING
 b6f0a577c4fbcc4f1e7eaf0e9a30bcfd20002b44
Message-ID: <20210722193529.GA333109@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60f90adb.rxbx86YHocAbz6Dy%lkp@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 22, 2021 at 02:06:19PM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git review/vga
> branch HEAD: b6f0a577c4fbcc4f1e7eaf0e9a30bcfd20002b44  FIXME PCI/VGA: Rework default VGA device selection
> 
> possible Warning in current branch:
> 
> drivers/pci/vgaarb.c:1045:8: warning: %d in format string (no. 6) requires 'int' but the argument type is 'unsigned int'. [invalidPrintfArgType_sint]

At b6f0a577c4fb ("FIXME PCI/VGA: Rework default VGA device
selection"), line 1045 in vgaarb.c does not contain a format string:

  1042  #define PCI_INVALID_CARD       ((struct pci_dev *)-1UL)
  1043
  1044  /*
  1045   * Each user has an array of these, tracking which cards have locks
  1046   */
  1047  struct vga_arb_user_card {
  1048          struct pci_dev *pdev;

Where's the info so I can reproduce this?  Compiler version and
options, .config file, etc?

> Warning ids grouped by kconfigs:
> 
> gcc_recent_errors
> `-- arm-randconfig-p001-20210720
>     `-- drivers-pci-vgaarb.c:warning:d-in-format-string-(no.-)-requires-int-but-the-argument-type-is-unsigned-int-.-invalidPrintfArgType_sint
