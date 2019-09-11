Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84C70AFCEB
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2019 14:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfIKMjs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Sep 2019 08:39:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37018 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbfIKMjr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Sep 2019 08:39:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id i1so23790811wro.4
        for <linux-pci@vger.kernel.org>; Wed, 11 Sep 2019 05:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dwr7geTx9+ke2SEfXb0XdiP/5AHzRCCREQ0jz0O3H24=;
        b=SOgetsuXOSouBSo+zRRExeA/CHTEmr/rasH6WVrzzZOnZA9wEe3TKvSwzSrqP852v9
         i2olFDQrezDy5AG3UK87fQa2KD7241ujoPgm7DZEAI7rlfzH2htfCjiJmc0sFaruE5FQ
         D3BJzMZcXBezH1QPjMkZO/bu/kZPPm7Xf/aQdz9MS6wT4mj+dKddcpfWSSdXZVbLSfCF
         06huTE2qmAmIqblEEoFMEX1ajo6SUCidGEGm37V96EIUeMmzWdhoErZ5ZDM1KEO6cp/W
         bUBLVRUYvZcaihabZYsJR9ejkuhrBr3hdOrlcM9L7itY1rM/mD1/U4SerWcMaJfAOH3H
         GBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dwr7geTx9+ke2SEfXb0XdiP/5AHzRCCREQ0jz0O3H24=;
        b=rYXy0FEzOaUEwa8GOdzk/pQYORhvE68V+puhVIkB5gpK1jqg+v3coUXHMkCwsybbni
         41/Qr4C1/cZQKHKh3JZIJEEAtTBcXt+auaN9PbO7rvLBB+1Jw1H24Qmi8cArMmgFPqyt
         Yw0D1Q+DgEvmYB30FYifBQDSCmIG53gMleO4aSEFpAOzgNbFuGhq6ubeeBAb9ubWVspw
         s33hV8xH/ePVnduHTnmO7r+EE6g/GQXAUgUZgfZCsO8U02wRRRhS9FD7T6cook9EiqvV
         yL4CvoZ0TFSGM3QKbpZdSaCmUm3ar5gffg09+5lWDkmyrVqgOrXd1X+DFeA1Tu/ulqoI
         rBGA==
X-Gm-Message-State: APjAAAWQIaFcxgsZxxb9WPSfpWpfo5YFxx7SIgpJP05JHQTCAV4RJh9r
        +Dm7dSn3dvs1Soj40Uk/GtOzXw==
X-Google-Smtp-Source: APXvYqw4upRPwH4xndlv1C6vfZX4nM9tDRuAekjc4YPPTWh2ab8+sveb6zx1lbwzeIiikFaOGILA0Q==
X-Received: by 2002:a5d:4081:: with SMTP id o1mr2076177wrp.41.1568205583708;
        Wed, 11 Sep 2019 05:39:43 -0700 (PDT)
Received: from [192.168.1.62] (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id r18sm23920698wrx.36.2019.09.11.05.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 05:39:43 -0700 (PDT)
Subject: Re: [PATCH 3/6] PCI: amlogic: meson: Add support for G12A
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     khilman@baylibre.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, yue.wang@Amlogic.com, kishon@ti.com,
        repk@triplefau.lt, maz@kernel.org,
        linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1567950178-4466-1-git-send-email-narmstrong@baylibre.com>
 <1567950178-4466-4-git-send-email-narmstrong@baylibre.com>
 <20190911113633.GR9720@e119886-lin.cambridge.arm.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 mQENBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAG0KE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT6JATsEEwEKACUC
 GyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheABQJXDO2CAhkBAAoJEBaat7Gkz/iubGIH/iyk
 RqvgB62oKOFlgOTYCMkYpm2aAOZZLf6VKHKc7DoVwuUkjHfIRXdslbrxi4pk5VKU6ZP9AKsN
 NtMZntB8WrBTtkAZfZbTF7850uwd3eU5cN/7N1Q6g0JQihE7w4GlIkEpQ8vwSg5W7hkx3yQ6
 2YzrUZh/b7QThXbNZ7xOeSEms014QXazx8+txR7jrGF3dYxBsCkotO/8DNtZ1R+aUvRfpKg5
 ZgABTC0LmAQnuUUf2PHcKFAHZo5KrdO+tyfL+LgTUXIXkK+tenkLsAJ0cagz1EZ5gntuheLD
 YJuzS4zN+1Asmb9kVKxhjSQOcIh6g2tw7vaYJgL/OzJtZi6JlIW5AQ0ETVkGzwEIALyKDN/O
 GURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYpQTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXM
 coJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hi
 SvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY4yG6xI99NIPEVE9lNBXBKIlewIyVlkOa
 YvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoMMtsyw18YoX9BqMFInxqYQQ3j/HpVgTSv
 mo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUXoUk33HEAEQEAAYkBHwQYAQIACQUCTVkG
 zwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfnM7IbRuiSZS1unlySUVYu3SD6YBYnNi3G
 5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa33eDIHu/zr1HMKErm+2SD6PO9umRef8V8
 2o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCSKmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+
 RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJ
 C3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTTQbM0WUIBIcGmq38+OgUsMYu4NzLu7uZF
 Acmp6h8guQINBFYnf6QBEADQ+wBYa+X2n/xIQz/RUoGHf84Jm+yTqRT43t7sO48/cBW9vAn9
 GNwnJ3HRJWKATW0ZXrCr40ES/JqM1fUTfiFDB3VMdWpEfwOAT1zXS+0rX8yljgsWR1UvqyEP
 3xN0M/40Zk+rdmZKaZS8VQaXbveaiWMEmY7sBV3QvgOzB7UF2It1HwoCon5Y+PvyE3CguhBd
 9iq5iEampkMIkbA3FFCpQFI5Ai3BywkLzbA3ZtnMXR8Qt9gFZtyXvFQrB+/6hDzEPnBGZOOx
 zkd/iIX59SxBuS38LMlhPPycbFNmtauOC0DNpXCv9ACgC9tFw3exER/xQgSpDVc4vrL2Cacr
 wmQp1k9E0W+9pk/l8S1jcHx03hgCxPtQLOIyEu9iIJb27TjcXNjiInd7Uea195NldIrndD+x
 58/yU3X70qVY+eWbqzpdlwF1KRm6uV0ZOQhEhbi0FfKKgsYFgBIBchGqSOBsCbL35f9hK/JC
 6LnGDtSHeJs+jd9/qJj4WqF3x8i0sncQ/gszSajdhnWrxraG3b7/9ldMLpKo/OoihfLaCxtv
 xYmtw8TGhlMaiOxjDrohmY1z7f3rf6njskoIXUO0nabun1nPAiV1dpjleg60s3OmVQeEpr3a
 K7gR1ljkemJzM9NUoRROPaT7nMlNYQL+IwuthJd6XQqwzp1jRTGG26J97wARAQABiQM+BBgB
 AgAJBQJWJ3+kAhsCAikJEBaat7Gkz/iuwV0gBBkBAgAGBQJWJ3+kAAoJEHfc29rIyEnRk6MQ
 AJDo0nxsadLpYB26FALZsWlN74rnFXth5dQVQ7SkipmyFWZhFL8fQ9OiIoxWhM6rSg9+C1w+
 n45eByMg2b8H3mmQmyWztdI95OxSREKwbaXVapCcZnv52JRjlc3DoiiHqTZML5x1Z7lQ1T3F
 8o9sKrbFO1WQw1+Nc91+MU0MGN0jtfZ0Tvn/ouEZrSXCE4K3oDGtj3AdC764yZVq6CPigCgs
 6Ex80k6QlzCdVP3RKsnPO2xQXXPgyJPJlpD8bHHHW7OLfoR9DaBNympfcbQJeekQrTvyoASw
 EOTPKE6CVWrcQIztUp0WFTdRGgMK0cZB3Xfe6sOp24PQTHAKGtjTHNP/THomkH24Fum9K3iM
 /4Wh4V2eqGEgpdeSp5K+LdaNyNgaqzMOtt4HYk86LYLSHfFXywdlbGrY9+TqiJ+ZVW4trmui
 NIJCOku8SYansq34QzYM0x3UFRwff+45zNBEVzctSnremg1mVgrzOfXU8rt+4N1b2MxorPF8
 619aCwVP7U16qNSBaqiAJr4e5SNEnoAq18+1Gp8QsFG0ARY8xp+qaKBByWES7lRi3QbqAKZf
 yOHS6gmYo9gBmuAhc65/VtHMJtxwjpUeN4Bcs9HUpDMDVHdfeRa73wM+wY5potfQ5zkSp0Jp
 bxnv/cRBH6+c43stTffprd//4Hgz+nJcCgZKtCYIAPkUxABC85ID2CidzbraErVACmRoizhT
 KR2OiqSLW2x4xdmSiFNcIWkWJB6Qdri0Fzs2dHe8etD1HYaht1ZhZ810s7QOL7JwypO8dscN
 KTEkyoTGn6cWj0CX+PeP4xp8AR8ot4d0BhtUY34UPzjE1/xyrQFAdnLd0PP4wXxdIUuRs0+n
 WLY9Aou/vC1LAdlaGsoTVzJ2gX4fkKQIWhX0WVk41BSFeDKQ3RQ2pnuzwedLO94Bf6X0G48O
 VsbXrP9BZ6snXyHfebPnno/te5XRqZTL9aJOytB/1iUna+1MAwBxGFPvqeEUUyT+gx1l3Acl
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <bb5794e7-44c6-c889-b555-21c531003548@baylibre.com>
Date:   Wed, 11 Sep 2019 14:39:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911113633.GR9720@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andrew,

On 11/09/2019 13:36, Andrew Murray wrote:
> On Sun, Sep 08, 2019 at 01:42:55PM +0000, Neil Armstrong wrote:
>> Add support for the Amlogic G12A SoC using a separate shared PHY.
>>
>> This adds support for fetching a PHY phandle and call the PHY init,
>> reset and power on/off calls instead of writing in the PHY register or
>> toggling the PHY reset line.
>>
>> The MIPI clock is also made optional since it is used for setting up
> 
> Is it worth indicating here that the MIPI clock is *only required* for
> the G12A (or controllers with a shared phy)? It's still required for
> AXG. It's not optional for G12A - it's ignored.

Indeed it's ignored, I'll reword it.

> 
>> the PHY reference clock chared with the DSI controller on AXG.
> 
> s/chared/shared/

Ack

> 
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/pci/controller/dwc/pci-meson.c | 101 ++++++++++++++++++++-----
>>  1 file changed, 84 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
>> index ab79990798f8..3fadad381762 100644
>> --- a/drivers/pci/controller/dwc/pci-meson.c
>> +++ b/drivers/pci/controller/dwc/pci-meson.c
>> @@ -16,6 +16,7 @@
>>  #include <linux/reset.h>
>>  #include <linux/resource.h>
>>  #include <linux/types.h>
>> +#include <linux/phy/phy.h>
>>  
>>  #include "pcie-designware.h"
>>  
>> @@ -96,12 +97,18 @@ struct meson_pcie_rc_reset {
>>  	struct reset_control *apb;
>>  };
>>  
>> +struct meson_pcie_param {
>> +	bool has_shared_phy;
>> +};
>> +
>>  struct meson_pcie {
>>  	struct dw_pcie pci;
>>  	struct meson_pcie_mem_res mem_res;
>>  	struct meson_pcie_clk_res clk_res;
>>  	struct meson_pcie_rc_reset mrst;
>>  	struct gpio_desc *reset_gpio;
>> +	struct phy *phy;
>> +	const struct meson_pcie_param *param;
>>  };
>>  
>>  static struct reset_control *meson_pcie_get_reset(struct meson_pcie *mp,
>> @@ -123,10 +130,12 @@ static int meson_pcie_get_resets(struct meson_pcie *mp)
>>  {
>>  	struct meson_pcie_rc_reset *mrst = &mp->mrst;
>>  
>> -	mrst->phy = meson_pcie_get_reset(mp, "phy", PCIE_SHARED_RESET);
>> -	if (IS_ERR(mrst->phy))
>> -		return PTR_ERR(mrst->phy);
>> -	reset_control_deassert(mrst->phy);
>> +	if (!mp->param->has_shared_phy) {
>> +		mrst->phy = meson_pcie_get_reset(mp, "phy", PCIE_SHARED_RESET);
>> +		if (IS_ERR(mrst->phy))
>> +			return PTR_ERR(mrst->phy);
>> +		reset_control_deassert(mrst->phy);
>> +	}
>>  
>>  	mrst->port = meson_pcie_get_reset(mp, "port", PCIE_NORMAL_RESET);
>>  	if (IS_ERR(mrst->port))
>> @@ -180,6 +189,9 @@ static int meson_pcie_get_mems(struct platform_device *pdev,
>>  	if (IS_ERR(mp->mem_res.cfg_base))
>>  		return PTR_ERR(mp->mem_res.cfg_base);
>>  
>> +	if (mp->param->has_shared_phy)
>> +		return 0;
>> +
> 
> It may be more consistent if, rather than returning here, you wrapped
> the following 3 lines by the if statement.

ok

> 
>>  	/* Meson SoC has two PCI controllers use same phy register*/
> 
> I guess this comment should now be updated to refer to AXG?

Indeed

> 
>>  	mp->mem_res.phy_base = meson_pcie_get_mem_shared(pdev, mp, "phy");
>>  	if (IS_ERR(mp->mem_res.phy_base))
>> @@ -188,19 +200,33 @@ static int meson_pcie_get_mems(struct platform_device *pdev,
>>  	return 0;
>>  }
>>  
>> -static void meson_pcie_power_on(struct meson_pcie *mp)
>> +static int meson_pcie_power_on(struct meson_pcie *mp)
>>  {
>> -	writel(MESON_PCIE_PHY_POWERUP, mp->mem_res.phy_base);
>> +	int ret = 0;
>> +
>> +	if (mp->param->has_shared_phy)
>> +		ret = phy_power_on(mp->phy);
> 
> I haven't seen any phy_[init/exit] calls, should there be any?

There is no _init() needed, but indeed we should still call them even it's
a no-op.

> 
>> +	else
>> +		writel(MESON_PCIE_PHY_POWERUP, mp->mem_res.phy_base);
>> +
>> +	return ret;
>>  }
>>  
>> -static void meson_pcie_reset(struct meson_pcie *mp)
>> +static int meson_pcie_reset(struct meson_pcie *mp)
>>  {
>>  	struct meson_pcie_rc_reset *mrst = &mp->mrst;
>> -
>> -	reset_control_assert(mrst->phy);
>> -	udelay(PCIE_RESET_DELAY);
>> -	reset_control_deassert(mrst->phy);
>> -	udelay(PCIE_RESET_DELAY);
>> +	int ret = 0;
>> +
>> +	if (mp->param->has_shared_phy) {
>> +		ret = phy_reset(mp->phy);
>> +		if (ret)
>> +			return ret;
>> +	} else {
>> +		reset_control_assert(mrst->phy);
>> +		udelay(PCIE_RESET_DELAY);
>> +		reset_control_deassert(mrst->phy);
>> +		udelay(PCIE_RESET_DELAY);
>> +	}
>>  
>>  	reset_control_assert(mrst->port);
>>  	reset_control_assert(mrst->apb);
>> @@ -208,6 +234,8 @@ static void meson_pcie_reset(struct meson_pcie *mp)
>>  	reset_control_deassert(mrst->port);
>>  	reset_control_deassert(mrst->apb);
>>  	udelay(PCIE_RESET_DELAY);
>> +
>> +	return 0;
>>  }
>>  
>>  static inline struct clk *meson_pcie_probe_clock(struct device *dev,
>> @@ -250,9 +278,11 @@ static int meson_pcie_probe_clocks(struct meson_pcie *mp)
>>  	if (IS_ERR(res->port_clk))
>>  		return PTR_ERR(res->port_clk);
>>  
>> -	res->mipi_gate = meson_pcie_probe_clock(dev, "mipi", 0);
>> -	if (IS_ERR(res->mipi_gate))
>> -		return PTR_ERR(res->mipi_gate);
>> +	if (!mp->param->has_shared_phy) {
>> +		res->mipi_gate = meson_pcie_probe_clock(dev, "mipi", 0);
>> +		if (IS_ERR(res->mipi_gate))
>> +			return PTR_ERR(res->mipi_gate);
>> +	}
>>  
>>  	res->general_clk = meson_pcie_probe_clock(dev, "general", 0);
>>  	if (IS_ERR(res->general_clk))
>> @@ -524,6 +554,7 @@ static const struct dw_pcie_ops dw_pcie_ops = {
>>  
>>  static int meson_pcie_probe(struct platform_device *pdev)
>>  {
>> +	const struct meson_pcie_param *match_data;
>>  	struct device *dev = &pdev->dev;
>>  	struct dw_pcie *pci;
>>  	struct meson_pcie *mp;
>> @@ -537,6 +568,20 @@ static int meson_pcie_probe(struct platform_device *pdev)
>>  	pci->dev = dev;
>>  	pci->ops = &dw_pcie_ops;
>>  
>> +	match_data = of_device_get_match_data(dev);
>> +	if (!match_data) {
>> +		dev_err(dev, "failed to get match data\n");
>> +		return -ENODEV;
>> +	}
>> +	mp->param = match_data;
>> +
>> +	if (mp->param->has_shared_phy) {
>> +		mp->phy = devm_phy_get(dev, "pcie");
>> +		if (IS_ERR(mp->phy)) {
>> +			return PTR_ERR(mp->phy);
>> +		}
>> +	}
>> +
>>  	mp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>>  	if (IS_ERR(mp->reset_gpio)) {
>>  		dev_err(dev, "get reset gpio failed\n");
>> @@ -555,8 +600,17 @@ static int meson_pcie_probe(struct platform_device *pdev)
>>  		return ret;
>>  	}
>>  
>> -	meson_pcie_power_on(mp);
>> -	meson_pcie_reset(mp);
>> +	ret = meson_pcie_power_on(mp);
>> +	if (ret) {
>> +		dev_err(dev, "phy power on failed, %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = meson_pcie_reset(mp);
>> +	if (ret) {
>> +		dev_err(dev, "reset failed, %d\n", ret);
>> +		return ret;
>> +	}
>>  
>>  	ret = meson_pcie_probe_clocks(mp);
>>  	if (ret) {
>> @@ -575,9 +629,22 @@ static int meson_pcie_probe(struct platform_device *pdev)
>>  	return 0;
>>  }
>>  
>> +static struct meson_pcie_param meson_pcie_axg_param = {
>> +	.has_shared_phy = false,
>> +};
>> +
>> +static struct meson_pcie_param meson_pcie_g12a_param = {
>> +	.has_shared_phy = true,
>> +};
>> +
>>  static const struct of_device_id meson_pcie_of_match[] = {
>>  	{
>>  		.compatible = "amlogic,axg-pcie",
>> +		.data = &meson_pcie_axg_param,
>> +	},
>> +	{
>> +		.compatible = "amlogic,g12a-pcie",
>> +		.data = &meson_pcie_g12a_param,
> 
> Here, we hard-code knowledge about the SOCs regarding if they have shared phys
> or not. I guess the alternative would have been to assume there is a shared
> phy if the DT has a phandle for it. I.e. instead of mp->param->has_shared_phy
> everywhere you could test for mp->phy. Though I guess at least with the
> current approach you guard against bad DTs, this seems OK.

I could split with if(mp->phy) and .needs_mipi_clk, but overall it would
be the same, and I wouldn't know how to react if we forget the PHY in g12a DT
since we wouldn't have the PHY register memory zone.
On G12A, the PHY is mandatory unlike AXG.

And finally this MIPI clock is part of the PHY ref clock, so I think
it's fine to wrap it in the .has_shared_phy knowledge.

Thanks for the review,
Neil

> 
> Thanks,
> 
> Andrew Murray
> 
>>  	},
>>  	{},
>>  };
>> -- 
>> 2.17.1
>>

