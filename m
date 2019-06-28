Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2ADD591C4
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2019 04:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfF1C6h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jun 2019 22:58:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfF1C6g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jun 2019 22:58:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B92A8356D4;
        Fri, 28 Jun 2019 02:58:33 +0000 (UTC)
Received: from jsavitz.bos.com (ovpn-123-72.rdu2.redhat.com [10.10.123.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B46BC60BE0;
        Fri, 28 Jun 2019 02:58:29 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] PCI: rpaphp: Avoid a sometimes-uninitialized warning
Date:   Thu, 27 Jun 2019 22:57:54 -0400
Message-Id: <1561690674-5880-1-git-send-email-jsavitz@redhat.com>
In-Reply-To: <20190603221157.58502-1-natechancellor@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 28 Jun 2019 02:58:36 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>On Mon, Jun 03, 2019 at 03:11:58PM -0700, Nathan Chancellor wrote:
>> When building with -Wsometimes-uninitialized, clang warns:
>> 
>> drivers/pci/hotplug/rpaphp_core.c:243:14: warning: variable 'fndit' is
>> used uninitialized whenever 'for' loop exits because its condition is
>> false [-Wsometimes-uninitialized]
>>         for (j = 0; j < entries; j++) {
>>                     ^~~~~~~~~~~
>> drivers/pci/hotplug/rpaphp_core.c:256:6: note: uninitialized use occurs
>> here
>>         if (fndit)
>>             ^~~~~
>> drivers/pci/hotplug/rpaphp_core.c:243:14: note: remove the condition if
>> it is always true
>>         for (j = 0; j < entries; j++) {
>>                     ^~~~~~~~~~~
>> drivers/pci/hotplug/rpaphp_core.c:233:14: note: initialize the variable
>> 'fndit' to silence this warning
>>         int j, fndit;
>>                     ^
>>                      = 0
>> 
>> fndit is only used to gate a sprintf call, which can be moved into the
>> loop to simplify the code and eliminate the local variable, which will
>> fix this warning.
>> 
>> Link: https://github.com/ClangBuiltLinux/linux/issues/504
>> Fixes: 2fcf3ae508c2 ("hotplug/drc-info: Add code to search ibm,drc-info property")
>> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
>> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>> ---
>> 
>> v1 -> v2:
>> 
>> * Eliminate fndit altogether by shuffling the sprintf call into the for
>>   loop and changing the if conditional, as suggested by Nick.
> 
>>  drivers/pci/hotplug/rpaphp_core.c | 18 +++++++-----------
>>  1 file changed, 7 insertions(+), 11 deletions(-)

>> Gentle ping, can someone pick this up?

Looks a good simplification of somewhat convoluted control flow.

Acked-by: Joel Savitz <jsavitz@redhat.com>
