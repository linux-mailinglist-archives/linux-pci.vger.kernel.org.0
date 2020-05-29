Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7628C1E751B
	for <lists+linux-pci@lfdr.de>; Fri, 29 May 2020 06:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgE2Esu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 May 2020 00:48:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:40312 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgE2Esu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 May 2020 00:48:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 88794AE7D;
        Fri, 29 May 2020 04:48:48 +0000 (UTC)
Subject: Re: [PATCH] xen/pci: Get rid of verbose_request and use dev_dbg()
 instead
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     bhelgaas@google.com, sstabellini@kernel.org, konrad.wilk@oracle.com
References: <1590719092-8578-1-git-send-email-boris.ostrovsky@oracle.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <f72d6b15-ab33-6815-5b38-f709ac50f7ab@suse.com>
Date:   Fri, 29 May 2020 06:48:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1590719092-8578-1-git-send-email-boris.ostrovsky@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 29.05.20 04:24, Boris Ostrovsky wrote:
> Information printed under verbose_request is clearly used for debugging
> only. Remove it and use dev_dbg() instead.
> 
> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen

