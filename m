Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6774496205
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 16:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240579AbiAUP1B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 10:27:01 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54750 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237525AbiAUP1B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 10:27:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2665B6198A
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 15:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6187FC340E1;
        Fri, 21 Jan 2022 15:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642778820;
        bh=oTpcl9eba6KvijvogYjYfbwybf+ZW/a6u5PFwsksl3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DE9qrWAPEweFbkcibozg4dqbgNhs4Z7NAu5cmFY6Npi6hynjsPp/uGw1M0TW5Rkh7
         3F/B8ZW6W+cfXCdrxHpsQgPCY1NLKcZ0/eD+ENpkYf9YU7Iphao2Czj3Og2bJk3gMb
         Ui1PioQmowzMNCRcrtUgeu3sfIeGRQTe72OcrQVvlwY2DllaOFVCq/n8shenBxKN0E
         oga0T5+c8W53SnlpwvbYiJZyEBNIRBtoD3l2Kzs+CeJ/1s0mCDEqcURknVwFsQqwwX
         +y/Qg/m7Dx21O4Ba+3u1yEspI6mZQBvGWq6bp/3vpZ/kh+ur//WDJImLFTAcqM7fOU
         LlSiodJApM+uQ==
Received: by pali.im (Postfix)
        id 096AF857; Fri, 21 Jan 2022 16:26:57 +0100 (CET)
Date:   Fri, 21 Jan 2022 16:26:57 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH pciutils 0/5] Support for PROGIF, REVID and SUBSYS
Message-ID: <20220121152657.xsq5f5u6odsumbwp@pali>
References: <20220121135718.27172-1-pali@kernel.org>
 <mj+md-20220121.143358.16196.nikam@ucw.cz>
 <20220121151246.3tlf5jdyh6jxeauv@pali>
 <mj+md-20220121.151403.26105.nikam@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mj+md-20220121.151403.26105.nikam@ucw.cz>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 21 January 2022 16:15:32 Martin Mareš wrote:
> Hello!
> 
> > How to handle situation when "class+subclass+prog_if" is provided and
> > revision is not provided? What should libpci backends set in this case?
> > Because on both Linux and Windows systems are these information provided
> > separately. On Linux you can chmod 000 revision sysfs file and let class
> > sysfs file still readable. Windows can probably decide itself that it
> > would not report revision at all...
> 
> Read it from the config registers in that case.

On Linux "class+subclass+prog_if" can be different than what is in
config registers and the purpose of this patch series with new fields is
to allow user to see difference in lspci.

On Windows access to real config space is not available for non-system
users.

> > And what to do with subsystem ids? They are not part of
> > class/subclass/prog_if/revision fields and different devices have them
> > stored on different locations... And for PCI-to-PCI bridges they are
> > only optional and does not have to be present at all.
> 
> I would prefer a separate PCI_FILL_xxx flag for them.

So like PCI_FILL_SUBSYS flag in this patch series?
