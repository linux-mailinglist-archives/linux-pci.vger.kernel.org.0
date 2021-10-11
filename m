Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C264296AC
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 20:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbhJKSR5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 14:17:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232064AbhJKSR4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Oct 2021 14:17:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12D2C60F14;
        Mon, 11 Oct 2021 18:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633976156;
        bh=9ePf3K3YVDyk/01dKSUq9edXkP56nCcpM8TKHIl9PAo=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=giaNLT3xhiHnqGPNJApAYnSm5TtGXo0lfCrSPsEtZ56D2xtIOmDI6qp1FERytUITv
         8y9BqRlBd3q9RiXUfDu9zKNRpWWhLqfWODVaM5MvVffY7zbDpioQIOe3DHPzk9mZmg
         T0+YKw/4PXsQQlSLmhK1MqWOY0KxLsiumyWer+HSy45jcUon9vfK49YA1PWRqJGWKs
         /bX99OJ4n/qB3o472J66cGa2V43QySse1v82FswLiiTmcuqXwNvSpdA5jWjaVt99cl
         dmDA/J+TVCRpL0ZFAGTCMuf59A90tm7YqmtN+OQzNHMsydRv2o90TQrVMv0UxADniL
         ieVYXTfgXYhnQ==
Received: by pali.im (Postfix)
        id DE3427C9; Mon, 11 Oct 2021 20:15:53 +0200 (CEST)
Date:   Mon, 11 Oct 2021 20:15:53 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Usage of PCBIOS_* macros (Was: Re: [PATCH 09/13] PCI: aardvark:
 Implement re-issuing config requests on CRS response)
Message-ID: <20211011181553.gnonl5lsa5bb7os3@pali>
References: <20211004121938.546d8f73@thinkpad>
 <20211005192826.GA1111810@bhelgaas>
 <20211006004531.42aace4d@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211006004531.42aace4d@thinkpad>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 06 October 2021 00:45:31 Marek Behún wrote:
> PS: Btw, looking at the code, why do we use these PCIBIOS_* macros? And 
> then sometimes convert them to error codes with pcibios_err_to_errno()? 
> Is this some legacy thing? Should this be converted to errno?

Hello! I would like to remind this Marek's PS. Do you know why config
read and write functions return these PCIBIOS_* macros and not standard
linux errno codes?
