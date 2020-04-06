Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E46471A001E
	for <lists+linux-pci@lfdr.de>; Mon,  6 Apr 2020 23:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgDFV2w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Apr 2020 17:28:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgDFV2w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Apr 2020 17:28:52 -0400
Received: from localhost (mobile-166-175-58-14.mycingular.net [166.175.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E1F82072A;
        Mon,  6 Apr 2020 21:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586208532;
        bh=Pf6xn/1C0WRzDBxdtlNxctydz4yPwNnWX4Ez1A6h66A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=V9XdyIhDzCHXyKBOqiOJgM0F4lhZuMRaO7clFjgm9KrQVNNcobUj8JubctiCsZM3/
         r4s8021mJ/KkTUvmeyW6TnSGWB4hXJETe+VVmEjsba1g9+PFvptXBKxLbVY783i45K
         sb1SHcxuc3+6MiIfXPPCscELVUyT/8cchUb8W8uw=
Date:   Mon, 6 Apr 2020 16:28:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Aman Sharma <amanharitsh123@gmail.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/5] pci: handled return value of platform_get_irq
 correctly
Message-ID: <20200406212849.GA36493@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311205723.GA177532@google.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 11, 2020 at 03:57:23PM -0500, Bjorn Helgaas wrote:
> ...
> When you post a revised series, make sure it's labeled "PATCH v2 0/5".

Hi Aman,

What's your thought on this series?  I'd really like to see it go
forward.  I think we have general agreement that checking "irq < 0" is
the right way to do this.

Bjorn
