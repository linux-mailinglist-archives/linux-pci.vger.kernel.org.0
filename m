Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016EE22B472
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jul 2020 19:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbgGWRM5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jul 2020 13:12:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730221AbgGWRMw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Jul 2020 13:12:52 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F55F22BF3;
        Thu, 23 Jul 2020 17:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595524372;
        bh=w4OmY5hcNzQfbvtkqtdBRmZocxa2mmGkh26J/9OPfzc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=zqaEaaehTFPl0ZbTqw279ct0PftgMnWx8nM8kHFSkJ4rUXtTeq6dFQqktjFwDOOAh
         tV5BYajYN+T/LOG+0/jMtCPOpcYmt8mwoQC6zxZOcEloA125igFvDcr7r7X0esnyMr
         QIlEQioaIrwImUgR7ylJShWdRycZyQ5CRUrxWBfI=
Date:   Thu, 23 Jul 2020 12:12:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ricky Wu <ricky_wu@realtek.com>, Rui Feng <rui_feng@realsil.com.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Ettle <james@ettle.org.uk>, Len Brown <lenb@kernel.org>,
        Puranjay Mohan <puranjay12@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jacopo De Simoi <wilderkde@gmail.com>
Subject: Re: rtsx_pci not restoring ASPM state after suspend/resume
Message-ID: <20200723171249.GA1422397@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723165622.GA1413555@bjorn-Precision-5520>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Jacopo]

On Thu, Jul 23, 2020 at 11:56:22AM -0500, Bjorn Helgaas wrote:
> James reported this issue with rtsx_pci; can you guys please take a
> look at it?  https://bugzilla.kernel.org/show_bug.cgi?id=208117
> 
> There's a lot of good info in the bugzilla already.

Likely duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=198951

Jacopo, could you please attach a complete dmesg log and "sudo lspci
-vvxxxx" output to your bugzilla?
