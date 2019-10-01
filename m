Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF40FC2E48
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 09:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732932AbfJAHji (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Oct 2019 03:39:38 -0400
Received: from alpha.anastas.io ([104.248.188.109]:59823 "EHLO
        alpha.anastas.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfJAHji (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Oct 2019 03:39:38 -0400
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by alpha.anastas.io (Postfix) with ESMTPSA id BB5987EC07;
        Tue,  1 Oct 2019 02:39:37 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
        t=1569915578; bh=VQh4VMtvPcD76Ubv0XIxwV4WJkxQWIK/yvw0SNifRtA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cyPOfDGMASmLbYq62mK5tqDVfbL80DfM5OgUiAqX4bzF47Nas/Xj83V40A6PpfG7g
         CA/KtXy2JHetwKfHetW4h4x1tICZeFTfVLV/+90cOMX54ZvY78CDoXSeHW1/i/9zzX
         CwZoMXG9tjykfvL/AzSYoBFcyCCh+zm85e50I10Mp5ajq8FVgNDHC5AexwkQjVEiqB
         CoCaPDtqh+GhqelrIDMncsM48wQCFKsC4SeoAWl8G6CHu7iAjdElPkjUtIqi0RegHY
         Rz8ulaSroUdjGMfAHtEu377eTTklDHo3PdXae5A85T+EncFZSWxVHFWCx4zFsplnWp
         /MNumFzdmtMyQ==
Subject: Re: IOMMU group creation for pseries hotplug, and powernv VFs
To:     Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc:     aik@ozlabs.ru, linux-pci@vger.kernel.org
References: <20190930020848.25767-1-oohall@gmail.com>
From:   Shawn Anastasio <shawn@anastas.io>
Message-ID: <de325701-e77c-8058-64fa-87ff4092c83f@anastas.io>
Date:   Tue, 1 Oct 2019 02:39:37 -0500
MIME-Version: 1.0
In-Reply-To: <20190930020848.25767-1-oohall@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/29/19 9:08 PM, Oliver O'Halloran wrote:
> A couple of extra patches on top of Shawn's existing re-ordering patch.
> This seems to fix the problem Alexey noted with Shawn's change causing
> VFs to lose their IOMMU group. I've tried pretty hard to make this a
> minimal fix it's still a bit large.
> 
> If mpe is happy to take this as a fix for 5.4 then I'll leave it,
> otherwise we might want to look at different approaches.
> 

Thanks for fixing this Oliver!

Reviewed-by: Shawn Anastasio <shawn@anastas.io>
