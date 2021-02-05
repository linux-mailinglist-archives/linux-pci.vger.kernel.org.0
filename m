Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD7A3105A9
	for <lists+linux-pci@lfdr.de>; Fri,  5 Feb 2021 08:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbhBEHNy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Feb 2021 02:13:54 -0500
Received: from ns.mm-sol.com ([37.157.136.199]:43332 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231421AbhBEHNs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Feb 2021 02:13:48 -0500
Received: from [192.168.0.4] (hst-221-80.medicom.bg [84.238.221.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: svarbanov@mm-sol.com)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 62E58D0E9;
        Fri,  5 Feb 2021 09:13:00 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1612509180; bh=aMPc/GniVkvvepsSdj/Sq8ITvYT3xLjeKhUfKrosELk=;
        h=Subject:To:Cc:From:Date:From;
        b=bDOnnHAxpOTzUFEt1HgHLAFt+PBniUeoRpOY8CuqSs8T464MhCQh3SMdrCuS+S5Jf
         90YmHY2HKCjwjbMhFl7g3Ef2FrbTCRQ5owVh7vRZacdQRH8ANYov1TSbwmGLwMKW9W
         Z/FpA97CvyUuMx4dgaMsG+pSJugJLxFuj/81JQ5j6enpuFXkC8NxVPwwGr6v5r+fKW
         BMrozcMcFXUr7mc1hBnEOb2fcxDLELtSyLrKM3xbCnRv8TzsL9SvdLkGnCDTtbegRO
         SyePF0yP9g6OuQbPkYO64bYoZ8DLv7hSRbQ4bMQehBVfncLz88vPZrMfSCR+PIrB2J
         azeNkjLGoGSKg==
Subject: Re: [PATCH v5 2/2] PCI: qcom: add support for ddrss_sf_tbu clock
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org
References: <20210117013114.441973-1-dmitry.baryshkov@linaro.org>
 <20210117013114.441973-3-dmitry.baryshkov@linaro.org>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <e57d12de-7e1c-5931-543a-013396097a91@mm-sol.com>
Date:   Fri, 5 Feb 2021 09:12:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210117013114.441973-3-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks for the patch!

On 1/17/21 3:31 AM, Dmitry Baryshkov wrote:
> On SM8250 additional clock is required for PCIe devices to access NOC.
> Update PCIe controller driver to control this clock.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Fixes: e1dd639e374a ("PCI: qcom: Add SM8250 SoC support")
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>


-- 
regards,
Stan
