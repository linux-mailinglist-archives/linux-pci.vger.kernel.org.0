Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0A6FC230
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2019 10:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfKNJIc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Nov 2019 04:08:32 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:39427 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbfKNJIc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Nov 2019 04:08:32 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47DFyP6TQRz9sRm; Thu, 14 Nov 2019 20:08:29 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 57409d4fb12c185b2c0689e0496878c8f6bb5b58
In-Reply-To: <1573449697-5448-2-git-send-email-tyreld@linux.ibm.com>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     nathanl@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>,
        tlfalcon@linux.ibm.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/9] powerpc/pseries: Fix bad drc_index_start value parsing of drc-info entry
Message-Id: <47DFyP6TQRz9sRm@ozlabs.org>
Date:   Thu, 14 Nov 2019 20:08:29 +1100 (AEDT)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2019-11-11 at 05:21:28 UTC, Tyrel Datwyler wrote:
> The ibm,drc-info property is an array property that contains drc-info
> entries such that each entry is made up of 2 string encoded elements
> followed by 5 int encoded elements. The of_read_drc_info_cell()
> helper contains comments that correctly name the expected elements
> and their encoding. However, the usage of of_prop_next_string() and
> of_prop_next_u32() introduced a subtle skippage of the first u32.
> This is a result of of_prop_next_string() returning a pointer to the
> next property value which is not a string, but actually a (__be32 *).
> As, a result the following call to of_prop_next_u32() passes over the
> current int encoded value and actually stores the next one wrongly.
> 
> Simply endian swap the current value in place after reading the first
> two string values. The remaining int encoded values can then be read
> correctly using of_prop_next_u32().
> 
> Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/57409d4fb12c185b2c0689e0496878c8f6bb5b58

cheers
