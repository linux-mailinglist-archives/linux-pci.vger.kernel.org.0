Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF30274A72
	for <lists+linux-pci@lfdr.de>; Tue, 22 Sep 2020 22:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgIVU4z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 16:56:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgIVU4z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Sep 2020 16:56:55 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FAFF2065D;
        Tue, 22 Sep 2020 20:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600808214;
        bh=w23Tp8zMDMR+UE8kJvtgaVeVoeMhyM1C6KfhRH9d1OM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WSJZZqyBzGY8B64QWbiho5uOZl1jGpj6c7TDM0VpMK9okur3c8DS1amwkXf9nKVnb
         EoUu5IZshV7o2YhKg0BNxEgsUp7xHPIfeTbI4yZFWmDnv5Mt56qg0C0ijYvbWXateN
         fh97/jv6sAtCUO9/dPjZGoE6Aakiqa+7Ki/rXUIE=
Date:   Tue, 22 Sep 2020 15:56:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: Re: [PATCH v9 1/5] PCI: Conditionally initialize host bridge
 native_* members
Message-ID: <20200922205652.GA2229548@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56d9af56-223a-c141-bc05-9499fbd5ff0a@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Sean]

On Tue, Sep 22, 2020 at 01:50:21PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> On 9/22/20 1:39 PM, Bjorn Helgaas wrote:
> > I got 1/5, 3/5, and 5/5 (and no cover letter).  Is there a 2/5 and a
> > 4/5?  Not sure if I should wait for more, or review these three as-is?
> I sent all 5 together with cover letter. Do you want me to send it again ?

I guess so.  I'm starting to suspect something wrong with Intel's
email path.

Sean had a similar problem a few days ago, and he re-sent the series,
and the resend also has the same problem.
