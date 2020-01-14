Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8D1D13B327
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2020 20:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgANTsq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 14:48:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:33926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgANTsq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jan 2020 14:48:46 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 940A524655;
        Tue, 14 Jan 2020 19:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579031326;
        bh=Jwtjbz1xWl2epV72DQ55JG7jJJ7iyLgmYALvx4gZz4M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=L1KzeYrIy55KkTvrJ5ex0kR+Iz1jl9gpFWZnB6xbgs9V7I+KBnRKxn4W72X4UxOUp
         0cxlWPXEOGmyqKuGEwlQsnHqMeigm+iw9EMpMetHRCKHkCXnzTT95K4CiQpATDNfTv
         hcCzWFVsRU/HMM8L5igYBAQQYJbvlCyhr71H6gxk=
Date:   Tue, 14 Jan 2020 13:48:43 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
Subject: Re: [PATCH v12 0/8] Add Error Disconnect Recover (EDR) support
Message-ID: <20200114194843.GA134677@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1578682741.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jan 12, 2020 at 02:43:54PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ...
> Changes since v11:
>  * Allowed error recovery to proceed after successful reset_link().
>  * Used correct ACPI handle for sending EDR status.
>  * Rebased on top of v5.5-rc5

You don't need to rebase this for *me*, since I always apply patches
on topic branches based on my "master" branch (typically -rc1) unless
they depend on something that's not in -rc1 (please tell me when this
is the case).

It usually doesn't *hurt* (and this series applies just fine on -rc1),
so this is just FYI.
