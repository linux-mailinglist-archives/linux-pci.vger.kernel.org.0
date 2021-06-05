Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC21D39C618
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jun 2021 07:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhFEFtM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Jun 2021 01:49:12 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:38771 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230233AbhFEFtM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 5 Jun 2021 01:49:12 -0400
Received: from [192.168.0.3] (ip5f5aeece.dynamic.kabel-deutschland.de [95.90.238.206])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0023361E64762;
        Sat,  5 Jun 2021 07:47:23 +0200 (CEST)
Subject: Re: [Intel-wired-lan] [PATCH next-queue v4 1/4] Revert "PCI: Make
 pci_enable_ptm() private"
To:     Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     netdev@vger.kernel.org, richardcochran@gmail.com,
        hch@infradead.org, linux-pci@vger.kernel.org, bhelgaas@google.com,
        intel-wired-lan@lists.osuosl.org
References: <20210604222542.GA2246166@bjorn-Precision-5520>
 <87bl8lxlbr.fsf@vcostago-mobl2.amr.corp.intel.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <61fbd916-ca4e-26b0-5d18-a2b2aa075a7f@molgen.mpg.de>
Date:   Sat, 5 Jun 2021 07:47:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87bl8lxlbr.fsf@vcostago-mobl2.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dear Vinicius, dear Bjorn,


Am 05.06.21 um 01:27 schrieb Vinicius Costa Gomes:
> Bjorn Helgaas <helgaas@kernel.org> writes:
> 
>> On Fri, Jun 04, 2021 at 03:09:30PM -0700, Vinicius Costa Gomes wrote:

[…]

>>> Exposing this to the driver enables the driver to use the
>>> 'ptm_enabled' field of 'pci_dev' to check if PTM is enabled or not.
>>>
>>> This reverts commit ac6c26da29c12fa511c877c273ed5c939dc9e96c.
>>
>> Ideally I would cite this as ac6c26da29c1 ("PCI: Make pci_enable_ptm()
>> private") so there's a little more context.
> 
> Yeah, that looks better.
> 
> Will follow the suggestions you made in the next patch as well and send
> another version, thanks.

Just a note, that this is how revert commits are generated by `git 
revert` as the name of the reverted commit is in the commit message 
summary. Maybe just move the statement/sentence to the very top? But 
either way is fine.


Kind regards,

Paul
