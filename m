Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371FE40CEDE
	for <lists+linux-pci@lfdr.de>; Wed, 15 Sep 2021 23:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhIOVch (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Sep 2021 17:32:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232481AbhIOVcd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Sep 2021 17:32:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1697A60E8B;
        Wed, 15 Sep 2021 21:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631741474;
        bh=bI66mLHpL0yw5TRPEX+W/OsSOWZc73ncH0HSbNXiS38=;
        h=Date:From:To:Subject:In-Reply-To:From;
        b=eGfJOiTew9Vyy3eP5u2eS50Mz7d3Zl+Wk/ytTt5T5pKSZPUQ/lJKGtqTN17F7suZb
         wzU95U5TLt/Fy082ZNKxT73RF/Ir6rv7w9bFDGEaBBsvnqkAZzU3cBO0pYMjoWA0W0
         Xk2yP/rYmPEEv8JJt1kV3Kje9RE5q13EuaFY0wZcmPvY8AfezGBG6xTVHxq6Z9o+Y5
         q9zadOVn1lrDtVuU0AYiNPC23liYIP1dtqQI0z/lSpcXEA/W6wDUAF2tbulrQME2NL
         8FTGn12HvCp5ReB9tHVugmZ1+2cHSvgYVIWT4VcWabdY0beXTFeSm45orT+oa+cUa8
         1fbLt3qxPAinQ==
Date:   Wed, 15 Sep 2021 16:31:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dave Jones <davej@codemonkey.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: Linux 5.15-rc1
Message-ID: <20210915213112.GA1541212@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914223327.GA14422@codemonkey.org.uk>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 14, 2021 at 06:33:27PM -0400, Dave Jones wrote:
> On Wed, Sep 15, 2021 at 12:06:33AM +0200, Heiner Kallweit wrote:
> 
>  > > What do you think of the following?  (This is a diff from v5.15-rc1.)
>  > > 
>  > 
>  > This looks very good to me.
> 
> fwiw, I tested this too, and it still works.

Thanks very much for proactively testing this.  I hated to burden you
before anybody else had looked at it.

I added this to for-linus for v5.15.

Bjorn
