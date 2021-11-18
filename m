Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C954562CA
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 19:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhKRStW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 13:49:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:53228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229812AbhKRStV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Nov 2021 13:49:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D323161101;
        Thu, 18 Nov 2021 18:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637261181;
        bh=wTdm8rH2x+XEEthfVic8qeMVJkyNGWEdcXxTxpeyzYg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=i+T1wzJdCAZeLsJtjirVb28BZHGj873LgLc7f2WLvbKQQi4dcNlF2OC9g15sPyMLu
         v4+4zMwNYC9L6E6EuwNf0BRMyynuOjemvd8Y7LK212zBTCbMuVRMYjQ+CVHxsO8y2Y
         BGFlMAv0RsqLwOszRrhq/Lcdb7/JvI4c4ON6OPHWh4aZuZTbnPuvB7BEaTPuu48Mxg
         fBRWEtPG4tGuDBmrRPchh8KtN7KQkflHbgvOsQKCSDa8FwJTUeh3DurPv5LxTX9f4G
         QNlUCOUJUpzSkp58VxuKarlR1VOH++fbsYIABdPhk0KohqH1ebEg0XFgFp5JHTqIol
         lOtgk0wzrC+SA==
Message-ID: <4925ab12-2406-916c-7594-f23de3ede068@kernel.org>
Date:   Thu, 18 Nov 2021 13:46:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: Query about secondary_bu_reset implementation
Content-Language: en-US
To:     Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, hch@lst.de
Cc:     Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        thierry.reding@gmail.com, linux-pci@vger.kernel.org
References: <40b03450-8f42-29d5-b65e-43644ec44940@nvidia.com>
 <0cc150cd-664f-05de-c8eb-81c81583cad7@nvidia.com>
From:   Sinan Kaya <okaya@kernel.org>
In-Reply-To: <0cc150cd-664f-05de-c8eb-81c81583cad7@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/18/2021 10:03 AM, Vidya Sagar wrote:
> Regarding the below commit that added pci_dev_wait() API to wait for the 
> device (supposed to be a downstream device.. i.e. and endpoint) get 
> ready, I'm wondering, given the 'dev' pointer here points to an upstream 
> device (i.e. a root port) because the same is passed to 
> pcibios_reset_secondary_bus() API, how is passing a root port's dev 
> pointer to pci_dev_wait() is going to serve the purpose?

> My understanding is that it would always get the response immediately as 
> the reset is applied to the endpoint here (through secondary bus reset) 
> and not to the root port, right? or am I missing something here?

Root port is not reset.
This is a link reset and recovery from link reset can take time per CRS
response.

We have seen some GPUs going all the way up to 60 seconds while
returning CRS response and waiting to reinitialize.
