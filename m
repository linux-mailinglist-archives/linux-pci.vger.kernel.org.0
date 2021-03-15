Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C2133B4F4
	for <lists+linux-pci@lfdr.de>; Mon, 15 Mar 2021 14:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhCONwa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Mar 2021 09:52:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229570AbhCONw3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Mar 2021 09:52:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90B5664D9E;
        Mon, 15 Mar 2021 13:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615816348;
        bh=rKKQeiICo8uU7lf6cZ5ilUHE0iv7JJ0zPh7r5swDxPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fA7suSNsVBtyNaigNsiFBbeOkv2dbaCa3xcc9ezmyXsYb1Vx0FKqSaD9pHEyYxtRw
         LNMt2XLRokZguE3dX0ChqfZ7j0Ga9XxNpS3kkuL7Nka7AwYySjLza5F+WfRP/rx3uj
         0pkeKbF0DGTQNRmtZ9/lCkbHNcKkd9wmmiD8zRqRbsp0pDjaUzBk23BEnb+3OXrTmE
         a471MPixLzv5oKvObRPqNChiuKQGeuP36JhqNsvCiZ7Vja+PD7RyXmf5kpisrJYbv5
         RmSn/Qkn530jkHNsSdhPw/sWvWFYWwzCA2g1o1+3QDx4Rm0qA/MpNVt0mskm1j3km7
         fksSh9s+mEIZg==
Received: by pali.im (Postfix)
        id 38842828; Mon, 15 Mar 2021 14:52:26 +0100 (CET)
Date:   Mon, 15 Mar 2021 14:52:26 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     bhelgaas@google.com, alex.williamson@redhat.com,
        raphael.norwitz@nutanix.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <20210315135226.avwmnhkfsgof6ihw@pali>
References: <20210312173452.3855-1-ameynarkhede03@gmail.com>
 <20210312173452.3855-5-ameynarkhede03@gmail.com>
 <20210314235545.girtrazsdxtrqo2q@pali>
 <20210315134323.llz2o7yhezwgealp@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315134323.llz2o7yhezwgealp@archlinux>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 15 March 2021 19:13:23 Amey Narkhede wrote:
> slot reset (pci_dev_reset_slot_function) and secondary bus
> reset(pci_parent_bus_reset) which I think are hot reset and
> warm reset respectively.

No. PCI secondary bus reset = PCIe Hot Reset. Slot reset is just another
type of reset, which is currently implemented only for PCIe hot plug
bridges and for PowerPC PowerNV platform and it just call PCI secondary
bus reset with some other hook. PCIe Warm Reset does not have API in
kernel and therefore drivers do not export this type of reset via any
kernel function (yet).
