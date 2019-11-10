Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26B94F6875
	for <lists+linux-pci@lfdr.de>; Sun, 10 Nov 2019 11:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfKJKUf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 10 Nov 2019 05:20:35 -0500
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:58153 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726650AbfKJKUf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 10 Nov 2019 05:20:35 -0500
Received: from [192.168.2.10] ([46.9.232.237])
        by smtp-cloud9.xs4all.net with ESMTPA
        id TkKEiNCYBQBsYTkKHi1TXf; Sun, 10 Nov 2019 11:20:24 +0100
Subject: Re: [PATCH v2 1/3] dt-bindings: power: Convert Generic Power Domain
 bindings to json-schema
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20191002160632.11140-1-krzk@kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <0b8e855a-0fb0-ebba-9df2-7aaab3b360f7@xs4all.nl>
Date:   Sun, 10 Nov 2019 11:20:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191002160632.11140-1-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfI09Qu6Y7XmEfsmDJtZgW515e0Zud/pWIcIDBEYAqJxnO0bTxvRN4fBz72qG8qkMvmz7pTmnqSaRfAFI/4gsJonnkrdlXpedpE4g9575DVCmRvHyn2l6
 MM/19Zy5r10YeSgAifDeEOX2LZ/6bN5innz9Wiqoh+COi5bmZuL+YLGPaHvBg1wf+FjdyLD/wBLbkKJfOANlRPCfRDfh61OdhNs+ZSIGr+fP9oivqNVFbRIS
 C794QPWAPi3wuN9JQBIlleGnmpcYKAvvMvBe5jOLCydCkAgTkqZDKEH5vz0p+mPl57RZCmXso0Sp8+Cjutcp9/uRsox0fUfaThjg5dwb5Dfiklg8KJK3AnRw
 9KQova5neLtf9Rb52xd5ElcZD9ScVRgU3jIW86gAvVJbeyfKn+JZ0kweUv9A0C2TIpQRpbPqU/XEiTNPMtGoAh/HitvzStqkhpFRHqnnRGHErVJItOLv+0mu
 fbPiyHeySQHMNw1JhwNxSRGu3PBcbgg1AhQzZ88SxFLwr3T90r9YYYx/vQFO94CnF5QfHSARi9UIJ/zPDM6cYe0odYg58+XqGv1EXDuzZPzpI5sKcRgXg8+Y
 EVqaPUAUnzjrbOiBVsXsxkeKjqgz1rmt7FUeYzjuI/eRlVCjWfHXCxI6Pxnk6tFflktU2ZV39a4iF9uxVwN+ajX2eQlwbN7BiWStHBzphB+58SRSHERdjfSX
 AC2+v0iy8JJ2+rnHEgAyEFa7rPO7pzxiXFw2IuLx94kJYvq9RugM70L1F7yGC5Xz7x5av6PZTG5zKnlhkuAmRr5P6VaXh2hVLdXcNWfDXWHQaVZCWdi0f2Cv
 bep5ARiCaX00VIDMTfSm2ziu01O7tjTQzFBmWMw0QuBJ1yH1wefxua7xbAPNunqp1tzd/gotey9UCuwl3CqRj8D4f9p+qGfdmx3y1q54i7unShznunrO20pP
 zUFjOOaaqjU2OC1ojmxQHno3tT0k9f/sz0//mtRw9WCrSu3vkO8u7Glh6AGk+tBzyygSbXvqQrSBqdgnzPXl9eoDqol5CNDDwpLTJ1tIhjcOJOW6F+SOchkU
 yf0gtejLVkV/x+xMG5RATPhdtVhdEzHd5S/+0v0Jm8PgSNBXBPNdIFuYZAqOTJhH5yV/HN4qgdBYxdT6Ikvd7kSULyXjvi/C68UI0BVjR6XtECGpiGJyxywW
 cK2HWc5fUazPmPpgSCBFvOlGKFrYLO8sHZh/RKckzR4=
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/2/19 6:06 PM, Krzysztof Kozlowski wrote:
> Convert Generic Power Domain bindings to DT schema format using
> json-schema.  The consumer bindings are split to separate file.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

For the media bindings:

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Thanks!

	Hans

> 
> ---
> 
> Changes since v1:
> 1. Select all nodes for consumers,
> 2. Remove from consumers duplicated properties with dt-schema,
> 3. Fix power domain pattern,
> 4. Remove unneeded types.
> ---
>  .../devicetree/bindings/arm/arm,scmi.txt      |   2 +-
>  .../devicetree/bindings/arm/arm,scpi.txt      |   2 +-
>  .../bindings/arm/freescale/fsl,scu.txt        |   2 +-
>  .../bindings/clock/clk-exynos-audss.txt       |   2 +-
>  .../bindings/clock/exynos5433-clock.txt       |   4 +-
>  .../bindings/clock/renesas,cpg-mssr.txt       |   2 +-
>  .../clock/renesas,r8a7778-cpg-clocks.txt      |   2 +-
>  .../clock/renesas,r8a7779-cpg-clocks.txt      |   2 +-
>  .../clock/renesas,rcar-gen2-cpg-clocks.txt    |   2 +-
>  .../bindings/clock/renesas,rz-cpg-clocks.txt  |   2 +-
>  .../bindings/clock/ti/davinci/psc.txt         |   2 +-
>  .../bindings/display/etnaviv/etnaviv-drm.txt  |   2 +-
>  .../devicetree/bindings/display/msm/dpu.txt   |   2 +-
>  .../devicetree/bindings/display/msm/mdp5.txt  |   2 +-
>  .../devicetree/bindings/dsp/fsl,dsp.yaml      |   2 +-
>  .../firmware/nvidia,tegra186-bpmp.txt         |   2 +-
>  .../bindings/media/imx7-mipi-csi2.txt         |   3 +-
>  .../bindings/media/mediatek-jpeg-decoder.txt  |   3 +-
>  .../bindings/media/mediatek-mdp.txt           |   3 +-
>  .../bindings/opp/qcom-nvmem-cpufreq.txt       |   2 +-
>  .../devicetree/bindings/pci/pci-keystone.txt  |   2 +-
>  .../bindings/phy/ti,phy-am654-serdes.txt      |   2 +-
>  .../bindings/power/amlogic,meson-gx-pwrc.txt  |   2 +-
>  .../devicetree/bindings/power/fsl,imx-gpc.txt |   2 +-
>  .../bindings/power/fsl,imx-gpcv2.txt          |   2 +-
>  .../power/power-domain-consumers.yaml         | 105 +++++++++
>  .../bindings/power/power-domain.yaml          | 134 ++++++++++++
>  .../bindings/power/power_domain.txt           | 205 ------------------
>  .../devicetree/bindings/power/qcom,rpmpd.txt  |   2 +-
>  .../bindings/power/renesas,rcar-sysc.txt      |   2 +-
>  .../bindings/power/renesas,sysc-rmobile.txt   |   2 +-
>  .../bindings/power/xlnx,zynqmp-genpd.txt      |   2 +-
>  .../bindings/soc/bcm/brcm,bcm2835-pm.txt      |   2 +-
>  .../bindings/soc/mediatek/scpsys.txt          |   2 +-
>  .../bindings/soc/ti/sci-pm-domain.txt         |   2 +-
>  .../bindings/usb/nvidia,tegra124-xusb.txt     |   4 +-
>  MAINTAINERS                                   |   2 +-
>  37 files changed, 278 insertions(+), 241 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/power-domain-consumers.yaml
>  create mode 100644 Documentation/devicetree/bindings/power/power-domain.yaml
>  delete mode 100644 Documentation/devicetree/bindings/power/power_domain.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> index 083dbf96ee00..f493d69e6194 100644
> --- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
> +++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> @@ -100,7 +100,7 @@ Required sub-node properties:
>  
>  [0] http://infocenter.arm.com/help/topic/com.arm.doc.den0056a/index.html
>  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> -[2] Documentation/devicetree/bindings/power/power_domain.txt
> +[2] Documentation/devicetree/bindings/power/power-domain.yaml
>  [3] Documentation/devicetree/bindings/thermal/thermal.txt
>  [4] Documentation/devicetree/bindings/sram/sram.txt
>  [5] Documentation/devicetree/bindings/reset/reset.txt
> diff --git a/Documentation/devicetree/bindings/arm/arm,scpi.txt b/Documentation/devicetree/bindings/arm/arm,scpi.txt
> index 401831973638..7b83ef43b418 100644
> --- a/Documentation/devicetree/bindings/arm/arm,scpi.txt
> +++ b/Documentation/devicetree/bindings/arm/arm,scpi.txt
> @@ -110,7 +110,7 @@ Required properties:
>  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>  [2] Documentation/devicetree/bindings/thermal/thermal.txt
>  [3] Documentation/devicetree/bindings/sram/sram.txt
> -[4] Documentation/devicetree/bindings/power/power_domain.txt
> +[4] Documentation/devicetree/bindings/power/power-domain.yaml
>  
>  Example:
>  
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> index c149fadc6f47..6c8a61b971f1 100644
> --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> @@ -124,7 +124,7 @@ Required properties for Pinctrl sub nodes:
>  			CONFIG settings.
>  
>  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> -[2] Documentation/devicetree/bindings/power/power_domain.txt
> +[2] Documentation/devicetree/bindings/power/power-domain.yaml
>  [3] Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
>  
>  RTC bindings based on SCU Message Protocol
> diff --git a/Documentation/devicetree/bindings/clock/clk-exynos-audss.txt b/Documentation/devicetree/bindings/clock/clk-exynos-audss.txt
> index 6030afb10b5c..fda095e1fa7a 100644
> --- a/Documentation/devicetree/bindings/clock/clk-exynos-audss.txt
> +++ b/Documentation/devicetree/bindings/clock/clk-exynos-audss.txt
> @@ -36,7 +36,7 @@ Required Properties:
>  Optional Properties:
>  
>    - power-domains: a phandle to respective power domain node as described by
> -    generic PM domain bindings (see power/power_domain.txt for more
> +    generic PM domain bindings (see power/power-domain-consumers.yaml for more
>      information).
>  
>  The following is the list of clocks generated by the controller. Each clock is
> diff --git a/Documentation/devicetree/bindings/clock/exynos5433-clock.txt b/Documentation/devicetree/bindings/clock/exynos5433-clock.txt
> index 183c327a7d6b..52880914228d 100644
> --- a/Documentation/devicetree/bindings/clock/exynos5433-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/exynos5433-clock.txt
> @@ -178,8 +178,8 @@ Required Properties:
>  
>  Optional properties:
>    - power-domains: a phandle to respective power domain node as described by
> -	generic PM domain bindings (see power/power_domain.txt for more
> -	information).
> +	generic PM domain bindings (see power/power-domain-consumers.yaml
> +	for more information).
>  
>  Each clock is assigned an identifier and client nodes can use this identifier
>  to specify the clock which they consume.
> diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
> index 916a601b76a7..2def42096886 100644
> --- a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
> @@ -59,7 +59,7 @@ Required Properties:
>  	power-managed through Module Standby should refer to the CPG device
>  	node in their "power-domains" property, as documented by the generic PM
>  	Domain bindings in
> -	Documentation/devicetree/bindings/power/power_domain.txt.
> +	Documentation/devicetree/bindings/power/power-domain.yaml.
>  
>    - #reset-cells: Must be 1
>        - The single reset specifier cell must be the module number, as defined
> diff --git a/Documentation/devicetree/bindings/clock/renesas,r8a7778-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,r8a7778-cpg-clocks.txt
> index 7cc4c0330b53..be24c2c023a2 100644
> --- a/Documentation/devicetree/bindings/clock/renesas,r8a7778-cpg-clocks.txt
> +++ b/Documentation/devicetree/bindings/clock/renesas,r8a7778-cpg-clocks.txt
> @@ -17,7 +17,7 @@ Required Properties:
>  SoC devices that are part of the CPG/MSTP Clock Domain and can be power-managed
>  through an MSTP clock should refer to the CPG device node in their
>  "power-domains" property, as documented by the generic PM domain bindings in
> -Documentation/devicetree/bindings/power/power_domain.txt.
> +Documentation/devicetree/bindings/power/power-domain-consumers.yaml.
>  
>  
>  Examples
> diff --git a/Documentation/devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt
> index 8c81547c29f5..263d7ef2e6de 100644
> --- a/Documentation/devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt
> +++ b/Documentation/devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt
> @@ -19,7 +19,7 @@ Required Properties:
>  SoC devices that are part of the CPG/MSTP Clock Domain and can be power-managed
>  through an MSTP clock should refer to the CPG device node in their
>  "power-domains" property, as documented by the generic PM domain bindings in
> -Documentation/devicetree/bindings/power/power_domain.txt.
> +Documentation/devicetree/bindings/power/power-domain-consumers.yaml.
>  
>  
>  Examples
> diff --git a/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
> index f8c05bb4116e..8c06a93ab730 100644
> --- a/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
> +++ b/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
> @@ -28,7 +28,7 @@ Required Properties:
>  SoC devices that are part of the CPG/MSTP Clock Domain and can be power-managed
>  through an MSTP clock should refer to the CPG device node in their
>  "power-domains" property, as documented by the generic PM domain bindings in
> -Documentation/devicetree/bindings/power/power_domain.txt.
> +Documentation/devicetree/bindings/power/power-domain-consumers.yaml.
>  
>  
>  Examples
> diff --git a/Documentation/devicetree/bindings/clock/renesas,rz-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,rz-cpg-clocks.txt
> index 8ff3e2774ed8..56d632165030 100644
> --- a/Documentation/devicetree/bindings/clock/renesas,rz-cpg-clocks.txt
> +++ b/Documentation/devicetree/bindings/clock/renesas,rz-cpg-clocks.txt
> @@ -21,7 +21,7 @@ Required Properties:
>  SoC devices that are part of the CPG/MSTP Clock Domain and can be power-managed
>  through an MSTP clock should refer to the CPG device node in their
>  "power-domains" property, as documented by the generic PM domain bindings in
> -Documentation/devicetree/bindings/power/power_domain.txt.
> +Documentation/devicetree/bindings/power/power-domain-consumers.yaml.
>  
>  
>  Examples
> diff --git a/Documentation/devicetree/bindings/clock/ti/davinci/psc.txt b/Documentation/devicetree/bindings/clock/ti/davinci/psc.txt
> index dae4ad8e198c..5f746ebf7a2c 100644
> --- a/Documentation/devicetree/bindings/clock/ti/davinci/psc.txt
> +++ b/Documentation/devicetree/bindings/clock/ti/davinci/psc.txt
> @@ -67,5 +67,5 @@ Examples:
>  
>  Also see:
>  - Documentation/devicetree/bindings/clock/clock-bindings.txt
> -- Documentation/devicetree/bindings/power/power_domain.txt
> +- Documentation/devicetree/bindings/power/power-domain.yaml
>  - Documentation/devicetree/bindings/reset/reset.txt
> diff --git a/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt b/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
> index 8def11b16a24..6067ef3f108a 100644
> --- a/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
> +++ b/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
> @@ -20,7 +20,7 @@ Required properties:
>  
>  Optional properties:
>  - power-domains: a power domain consumer specifier according to
> -  Documentation/devicetree/bindings/power/power_domain.txt
> +  Documentation/devicetree/bindings/power/power-domain-consumers.yaml
>  
>  example:
>  
> diff --git a/Documentation/devicetree/bindings/display/msm/dpu.txt b/Documentation/devicetree/bindings/display/msm/dpu.txt
> index a61dd40f3792..002a3a1270f9 100644
> --- a/Documentation/devicetree/bindings/display/msm/dpu.txt
> +++ b/Documentation/devicetree/bindings/display/msm/dpu.txt
> @@ -13,7 +13,7 @@ Required properties:
>  - reg-names: register region names. The following region is required:
>    * "mdss"
>  - power-domains: a power domain consumer specifier according to
> -  Documentation/devicetree/bindings/power/power_domain.txt
> +  Documentation/devicetree/bindings/power/power-domain-consumers.yaml
>  - clocks: list of clock specifiers for clocks needed by the device.
>  - clock-names: device clock names, must be in same order as clocks property.
>    The following clocks are required:
> diff --git a/Documentation/devicetree/bindings/display/msm/mdp5.txt b/Documentation/devicetree/bindings/display/msm/mdp5.txt
> index 4e11338548aa..9cbfcdfa46b4 100644
> --- a/Documentation/devicetree/bindings/display/msm/mdp5.txt
> +++ b/Documentation/devicetree/bindings/display/msm/mdp5.txt
> @@ -19,7 +19,7 @@ Required properties:
>  - #interrupt-cells: specifies the number of cells needed to encode an interrupt
>    source, should be 1.
>  - power-domains: a power domain consumer specifier according to
> -  Documentation/devicetree/bindings/power/power_domain.txt
> +  Documentation/devicetree/bindings/power/power-domain-consumers.yaml
>  - clocks: device clocks. See ../clocks/clock-bindings.txt for details.
>  - clock-names: the following clocks are required.
>    * "iface"
> diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> index 3248595dc93c..d7680b7fbe19 100644
> --- a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> +++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> @@ -36,7 +36,7 @@ properties:
>    power-domains:
>      description:
>        List of phandle and PM domain specifier as documented in
> -      Documentation/devicetree/bindings/power/power_domain.txt
> +      Documentation/devicetree/bindings/power/power-domain-consumers.yaml
>      maxItems: 4
>  
>    mboxes:
> diff --git a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
> index ff380dadb5f9..e44a13bc06ed 100644
> --- a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
> +++ b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
> @@ -32,7 +32,7 @@ implemented by this node:
>  
>  - .../clock/clock-bindings.txt
>  - <dt-bindings/clock/tegra186-clock.h>
> -- ../power/power_domain.txt
> +- ../power/power-domain.yaml
>  - <dt-bindings/power/tegra186-powergate.h>
>  - .../reset/reset.txt
>  - <dt-bindings/reset/tegra186-reset.h>
> diff --git a/Documentation/devicetree/bindings/media/imx7-mipi-csi2.txt b/Documentation/devicetree/bindings/media/imx7-mipi-csi2.txt
> index 71fd74ed3ec8..7a7a8b672983 100644
> --- a/Documentation/devicetree/bindings/media/imx7-mipi-csi2.txt
> +++ b/Documentation/devicetree/bindings/media/imx7-mipi-csi2.txt
> @@ -17,7 +17,8 @@ Required properties:
>  - clock-names   : must contain "pclk", "wrap" and "phy" entries, matching
>                    entries in the clock property;
>  - power-domains : a phandle to the power domain, see
> -          Documentation/devicetree/bindings/power/power_domain.txt for details.
> +          Documentation/devicetree/bindings/power/power-domain-consumers.yaml
> +          for details.
>  - reset-names   : should include following entry "mrst";
>  - resets        : a list of phandle, should contain reset entry of
>                    reset-names;
> diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt b/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
> index 044b11913c49..04c46adaa460 100644
> --- a/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
> +++ b/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
> @@ -14,7 +14,8 @@ Required properties:
>    Documentation/devicetree/bindings/clock/clock-bindings.txt for details.
>  - clock-names: must contain "jpgdec-smi" and "jpgdec".
>  - power-domains: a phandle to the power domain, see
> -  Documentation/devicetree/bindings/power/power_domain.txt for details.
> +  Documentation/devicetree/bindings/power/power-domain-consumers.yaml
> +  for details.
>  - mediatek,larb: must contain the local arbiters in the current Socs, see
>    Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
>    for details.
> diff --git a/Documentation/devicetree/bindings/media/mediatek-mdp.txt b/Documentation/devicetree/bindings/media/mediatek-mdp.txt
> index 0d03e3ae2be2..5a8c9ab9b3bd 100644
> --- a/Documentation/devicetree/bindings/media/mediatek-mdp.txt
> +++ b/Documentation/devicetree/bindings/media/mediatek-mdp.txt
> @@ -17,7 +17,8 @@ Required properties (all function blocks, child node):
>  - clocks: device clocks, see
>    Documentation/devicetree/bindings/clock/clock-bindings.txt for details.
>  - power-domains: a phandle to the power domain, see
> -  Documentation/devicetree/bindings/power/power_domain.txt for details.
> +  Documentation/devicetree/bindings/power/power-domain-consumers.yaml
> +  for details.
>  
>  Required properties (DMA function blocks, child node):
>  - compatible: Should be one of
> diff --git a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> index 4751029b9b74..cb091b2ce5db 100644
> --- a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> +++ b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> @@ -27,7 +27,7 @@ In 'cpu' nodes:
>  - power-domains: A phandle pointing to the PM domain specifier which provides
>  		the performance states available for active state management.
>  		Please refer to the power-domains bindings
> -		Documentation/devicetree/bindings/power/power_domain.txt
> +		Documentation/devicetree/bindings/power/power-domain-consumers.yaml
>  		and also examples below.
>  - power-domain-names: Should be
>  	- 'cpr' for qcs404.
> diff --git a/Documentation/devicetree/bindings/pci/pci-keystone.txt b/Documentation/devicetree/bindings/pci/pci-keystone.txt
> index 47202a2938f2..5ee0bf171ce6 100644
> --- a/Documentation/devicetree/bindings/pci/pci-keystone.txt
> +++ b/Documentation/devicetree/bindings/pci/pci-keystone.txt
> @@ -88,7 +88,7 @@ num-ob-windows: As specified in
>  num-lanes: As specified in
>  	   Documentation/devicetree/bindings/pci/designware-pcie.txt
>  power-domains: As documented by the generic PM domain bindings in
> -	       Documentation/devicetree/bindings/power/power_domain.txt.
> +	       Documentation/devicetree/bindings/power/power-domain-consumers.yaml.
>  ti,syscon-pcie-mode: phandle to the device control module required to configure
>  		      PCI in either RC mode or EP mode.
>  
> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.txt b/Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.txt
> index 64b286d2d398..b5f17a3e8dba 100644
> --- a/Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.txt
> +++ b/Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.txt
> @@ -17,7 +17,7 @@ Required properties:
>  		1 - PCIe0 Lane1
>  		2 - ICSS2 SGMII Lane1
>   - power-domains: As documented by the generic PM domain bindings in
> -	Documentation/devicetree/bindings/power/power_domain.txt.
> +	Documentation/devicetree/bindings/power/power-domain-consumers.yaml.
>   - clocks: List of clock-specifiers representing the input to the SERDES.
>  	Should have 3 items representing the left input clock, external
>  	reference clock and right input clock in that order.
> diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-gx-pwrc.txt b/Documentation/devicetree/bindings/power/amlogic,meson-gx-pwrc.txt
> index 0fdc3dd1125e..99b5b10cda31 100644
> --- a/Documentation/devicetree/bindings/power/amlogic,meson-gx-pwrc.txt
> +++ b/Documentation/devicetree/bindings/power/amlogic,meson-gx-pwrc.txt
> @@ -10,7 +10,7 @@ The Video Processing Unit power domain is controlled by this power controller,
>  but the domain requires some external resources to meet the correct power
>  sequences.
>  The bindings must respect the power domain bindings as described in the file
> -power_domain.txt
> +power-domain.yaml
>  
>  Device Tree Bindings:
>  ---------------------
> diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt b/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
> index 726ec2875223..f0f5553a9e74 100644
> --- a/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
> +++ b/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
> @@ -19,7 +19,7 @@ Required properties:
>    - ipg
>  
>  The power domains are generic power domain providers as documented in
> -Documentation/devicetree/bindings/power/power_domain.txt. They are described as
> +Documentation/devicetree/bindings/power/power-domain.yaml. They are described as
>  subnodes of the power gating controller 'pgc' node of the GPC and should
>  contain the following:
>  
> diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
> index 7c7e972aaa42..61649202f6f5 100644
> --- a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
> +++ b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
> @@ -17,7 +17,7 @@ Required properties:
>  
>  Power domains contained within GPC node are generic power domain
>  providers, documented in
> -Documentation/devicetree/bindings/power/power_domain.txt, which are
> +Documentation/devicetree/bindings/power/power-domain.yaml, which are
>  described as subnodes of the power gating controller 'pgc' node,
>  which, in turn, is expected to contain the following:
>  
> diff --git a/Documentation/devicetree/bindings/power/power-domain-consumers.yaml b/Documentation/devicetree/bindings/power/power-domain-consumers.yaml
> new file mode 100644
> index 000000000000..f65078e1260e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/power-domain-consumers.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/power-domain-consumers.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PM domain consumers
> +
> +maintainers:
> +  - Rafael J. Wysocki <rjw@rjwysocki.net>
> +  - Kevin Hilman <khilman@kernel.org>
> +  - Ulf Hansson <ulf.hansson@linaro.org>
> +
> +description: |+
> +  See power-domain.yaml
> +
> +select: true
> +
> +allOf:
> +  - $ref: /schemas/power-domain/power-domain-consumer.yaml
> +
> +properties:
> +  required-opps:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      This contains phandle to an OPP node in another device's OPP table.
> +      It may contain an array of phandles, where each phandle points to an OPP
> +      of a different device. It should not contain multiple phandles to the OPP
> +      nodes in the same OPP table. This specifies the minimum required OPP
> +      of the device(s), whose OPP's phandle is present in this property,
> +      for the functioning of the current device at the current OPP (where this
> +      property is present).
> +
> +examples:
> +  - |
> +    leaky-device@12350000 {
> +      compatible = "foo,i-leak-current";
> +      reg = <0x12350000 0x1000>;
> +      power-domains = <&power 0>;
> +      power-domain-names = "io";
> +    };
> +
> +    leaky-device@12351000 {
> +      compatible = "foo,i-leak-current";
> +      reg = <0x12351000 0x1000>;
> +      power-domains = <&power 0>, <&power 1> ;
> +      power-domain-names = "io", "clk";
> +    };
> +
> +    // The first example above defines a typical PM domain consumer device, which is
> +    // located inside a PM domain with index 0 of a power controller represented by a
> +    // node with the label "power".
> +    // In the second example the consumer device are partitioned across two PM domains,
> +    // the first with index 0 and the second with index 1, of a power controller that
> +    // is represented by a node with the label "power".
> +
> +  - |
> +    // Example with  OPP table for domain provider that provides two domains:
> +
> +    domain0_opp_table: opp-table0 {
> +      compatible = "operating-points-v2";
> +
> +      domain0_opp_0: opp-1000000000 {
> +        opp-hz = /bits/ 64 <1000000000>;
> +        opp-microvolt = <975000 970000 985000>;
> +      };
> +      domain0_opp_1: opp-1100000000 {
> +        opp-hz = /bits/ 64 <1100000000>;
> +        opp-microvolt = <1000000 980000 1010000>;
> +      };
> +    };
> +
> +    domain1_opp_table: opp-table1 {
> +      compatible = "operating-points-v2";
> +
> +      domain1_opp_0: opp-1200000000 {
> +        opp-hz = /bits/ 64 <1200000000>;
> +        opp-microvolt = <975000 970000 985000>;
> +      };
> +      domain1_opp_1: opp-1300000000 {
> +        opp-hz = /bits/ 64 <1300000000>;
> +        opp-microvolt = <1000000 980000 1010000>;
> +      };
> +    };
> +
> +    power: power-controller@12340000 {
> +      compatible = "foo,power-controller";
> +      reg = <0x12340000 0x1000>;
> +      #power-domain-cells = <1>;
> +      operating-points-v2 = <&domain0_opp_table>, <&domain1_opp_table>;
> +    };
> +
> +    leaky-device0@12350000 {
> +      compatible = "foo,i-leak-current";
> +      reg = <0x12350000 0x1000>;
> +      power-domains = <&power 0>;
> +      required-opps = <&domain0_opp_0>;
> +    };
> +
> +    leaky-device1@12350000 {
> +      compatible = "foo,i-leak-current";
> +      reg = <0x12350000 0x1000>;
> +      power-domains = <&power 1>;
> +      required-opps = <&domain1_opp_1>;
> +    };
> diff --git a/Documentation/devicetree/bindings/power/power-domain.yaml b/Documentation/devicetree/bindings/power/power-domain.yaml
> new file mode 100644
> index 000000000000..dd1376cff51b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/power-domain.yaml
> @@ -0,0 +1,134 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/power-domain.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic PM domains
> +
> +maintainers:
> +  - Rafael J. Wysocki <rjw@rjwysocki.net>
> +  - Kevin Hilman <khilman@kernel.org>
> +  - Ulf Hansson <ulf.hansson@linaro.org>
> +
> +description: |+
> +  System on chip designs are often divided into multiple PM domains that can be
> +  used for power gating of selected IP blocks for power saving by reduced leakage
> +  current.
> +
> +  This device tree binding can be used to bind PM domain consumer devices with
> +  their PM domains provided by PM domain providers. A PM domain provider can be
> +  represented by any node in the device tree and can provide one or more PM
> +  domains. A consumer node can refer to the provider by a phandle and a set of
> +  phandle arguments (so called PM domain specifiers) of length specified by the
> +  \#power-domain-cells property in the PM domain provider node.
> +
> +properties:
> +  $nodename:
> +    pattern: "^(power-controller|power-domain)(@.*)?$"
> +
> +  domain-idle-states:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      A phandle of an idle-state that shall be soaked into a generic domain
> +      power state. The idle state definitions are compatible with
> +      domain-idle-state specified in
> +      Documentation/devicetree/bindings/power/domain-idle-state.txt
> +      phandles that are not compatible with domain-idle-state will be ignored.
> +      The domain-idle-state property reflects the idle state of this PM domain
> +      and not the idle states of the devices or sub-domains in the PM domain.
> +      Devices and sub-domains have their own idle-states independent
> +      of the parent domain's idle states. In the absence of this property,
> +      the domain would be considered as capable of being powered-on
> +      or powered-off.
> +
> +  operating-points-v2:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      Phandles to the OPP tables of power domains provided by a power domain
> +      provider. If the provider provides a single power domain only or all
> +      the power domains provided by the provider have identical OPP tables,
> +      then this shall contain a single phandle. Refer to ../opp/opp.txt
> +      for more information.
> +
> +  "#power-domain-cells":
> +    description:
> +      Number of cells in a PM domain specifier. Typically 0 for nodes
> +      representing a single PM domain and 1 for nodes providing multiple PM
> +      domains (e.g. power controllers), but can be any value as specified
> +      by device tree binding documentation of particular provider.
> +
> +  power-domains:
> +    description:
> +       A phandle and PM domain specifier as defined by bindings of the power
> +       controller specified by phandle. Some power domains might be powered
> +       from another power domain (or have other hardware specific
> +       dependencies). For representing such dependency a standard PM domain
> +       consumer binding is used. When provided, all domains created
> +       by the given provider should be subdomains of the domain specified
> +       by this binding. More details about power domain specifier are
> +       available in the power-domain-consumers.yaml.
> +
> +required:
> +  - "#power-domain-cells"
> +
> +examples:
> +  - |
> +    power: power-controller@12340000 {
> +      compatible = "foo,power-controller";
> +      reg = <0x12340000 0x1000>;
> +      #power-domain-cells = <1>;
> +    };
> +
> +    // The node above defines a power controller that is a PM domain provider and
> +    // expects one cell as its phandle argument.
> +
> +  - |
> +    parent2: power-controller@12340000 {
> +      compatible = "foo,power-controller";
> +      reg = <0x12340000 0x1000>;
> +      #power-domain-cells = <1>;
> +    };
> +
> +    child2: power-controller@12341000 {
> +      compatible = "foo,power-controller";
> +      reg = <0x12341000 0x1000>;
> +      power-domains = <&parent2 0>;
> +      #power-domain-cells = <1>;
> +    };
> +
> +    // The nodes above define two power controllers: 'parent' and 'child'.
> +    // Domains created by the 'child' power controller are subdomains of '0' power
> +    // domain provided by the 'parent' power controller.
> +
> +  - |
> +    parent3: power-controller@12340000 {
> +      compatible = "foo,power-controller";
> +      reg = <0x12340000 0x1000>;
> +      #power-domain-cells = <0>;
> +      domain-idle-states = <&DOMAIN_RET>, <&DOMAIN_PWR_DN>;
> +    };
> +
> +    child3: power-controller@12341000 {
> +      compatible = "foo,power-controller";
> +      reg = <0x12341000 0x1000>;
> +      power-domains = <&parent3>;
> +      #power-domain-cells = <0>;
> +      domain-idle-states = <&DOMAIN_PWR_DN>;
> +    };
> +
> +    DOMAIN_RET: state@0 {
> +      compatible = "domain-idle-state";
> +      reg = <0x0 0x0>;
> +      entry-latency-us = <1000>;
> +      exit-latency-us = <2000>;
> +      min-residency-us = <10000>;
> +    };
> +
> +    DOMAIN_PWR_DN: state@1 {
> +      compatible = "domain-idle-state";
> +      reg = <0x1 0x0>;
> +      entry-latency-us = <5000>;
> +      exit-latency-us = <8000>;
> +      min-residency-us = <7000>;
> +    };
> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
> deleted file mode 100644
> index 8f8b25a24b8f..000000000000
> --- a/Documentation/devicetree/bindings/power/power_domain.txt
> +++ /dev/null
> @@ -1,205 +0,0 @@
> -* Generic PM domains
> -
> -System on chip designs are often divided into multiple PM domains that can be
> -used for power gating of selected IP blocks for power saving by reduced leakage
> -current.
> -
> -This device tree binding can be used to bind PM domain consumer devices with
> -their PM domains provided by PM domain providers. A PM domain provider can be
> -represented by any node in the device tree and can provide one or more PM
> -domains. A consumer node can refer to the provider by a phandle and a set of
> -phandle arguments (so called PM domain specifiers) of length specified by the
> -#power-domain-cells property in the PM domain provider node.
> -
> -==PM domain providers==
> -
> -Required properties:
> - - #power-domain-cells : Number of cells in a PM domain specifier;
> -   Typically 0 for nodes representing a single PM domain and 1 for nodes
> -   providing multiple PM domains (e.g. power controllers), but can be any value
> -   as specified by device tree binding documentation of particular provider.
> -
> -Optional properties:
> - - power-domains : A phandle and PM domain specifier as defined by bindings of
> -                   the power controller specified by phandle.
> -   Some power domains might be powered from another power domain (or have
> -   other hardware specific dependencies). For representing such dependency
> -   a standard PM domain consumer binding is used. When provided, all domains
> -   created by the given provider should be subdomains of the domain
> -   specified by this binding. More details about power domain specifier are
> -   available in the next section.
> -
> -- domain-idle-states : A phandle of an idle-state that shall be soaked into a
> -                generic domain power state. The idle state definitions are
> -                compatible with domain-idle-state specified in [1]. phandles
> -                that are not compatible with domain-idle-state will be
> -                ignored.
> -  The domain-idle-state property reflects the idle state of this PM domain and
> -  not the idle states of the devices or sub-domains in the PM domain. Devices
> -  and sub-domains have their own idle-states independent of the parent
> -  domain's idle states. In the absence of this property, the domain would be
> -  considered as capable of being powered-on or powered-off.
> -
> -- operating-points-v2 : Phandles to the OPP tables of power domains provided by
> -  a power domain provider. If the provider provides a single power domain only
> -  or all the power domains provided by the provider have identical OPP tables,
> -  then this shall contain a single phandle. Refer to ../opp/opp.txt for more
> -  information.
> -
> -Example:
> -
> -	power: power-controller@12340000 {
> -		compatible = "foo,power-controller";
> -		reg = <0x12340000 0x1000>;
> -		#power-domain-cells = <1>;
> -	};
> -
> -The node above defines a power controller that is a PM domain provider and
> -expects one cell as its phandle argument.
> -
> -Example 2:
> -
> -	parent: power-controller@12340000 {
> -		compatible = "foo,power-controller";
> -		reg = <0x12340000 0x1000>;
> -		#power-domain-cells = <1>;
> -	};
> -
> -	child: power-controller@12341000 {
> -		compatible = "foo,power-controller";
> -		reg = <0x12341000 0x1000>;
> -		power-domains = <&parent 0>;
> -		#power-domain-cells = <1>;
> -	};
> -
> -The nodes above define two power controllers: 'parent' and 'child'.
> -Domains created by the 'child' power controller are subdomains of '0' power
> -domain provided by the 'parent' power controller.
> -
> -Example 3:
> -	parent: power-controller@12340000 {
> -		compatible = "foo,power-controller";
> -		reg = <0x12340000 0x1000>;
> -		#power-domain-cells = <0>;
> -		domain-idle-states = <&DOMAIN_RET>, <&DOMAIN_PWR_DN>;
> -	};
> -
> -	child: power-controller@12341000 {
> -		compatible = "foo,power-controller";
> -		reg = <0x12341000 0x1000>;
> -		power-domains = <&parent>;
> -		#power-domain-cells = <0>;
> -		domain-idle-states = <&DOMAIN_PWR_DN>;
> -	};
> -
> -	DOMAIN_RET: state@0 {
> -		compatible = "domain-idle-state";
> -		reg = <0x0>;
> -		entry-latency-us = <1000>;
> -		exit-latency-us = <2000>;
> -		min-residency-us = <10000>;
> -	};
> -
> -	DOMAIN_PWR_DN: state@1 {
> -		compatible = "domain-idle-state";
> -		reg = <0x1>;
> -		entry-latency-us = <5000>;
> -		exit-latency-us = <8000>;
> -		min-residency-us = <7000>;
> -	};
> -
> -==PM domain consumers==
> -
> -Required properties:
> - - power-domains : A list of PM domain specifiers, as defined by bindings of
> -		the power controller that is the PM domain provider.
> -
> -Optional properties:
> - - power-domain-names : A list of power domain name strings sorted in the same
> -		order as the power-domains property. Consumers drivers will use
> -		power-domain-names to match power domains with power-domains
> -		specifiers.
> -
> -Example:
> -
> -	leaky-device@12350000 {
> -		compatible = "foo,i-leak-current";
> -		reg = <0x12350000 0x1000>;
> -		power-domains = <&power 0>;
> -		power-domain-names = "io";
> -	};
> -
> -	leaky-device@12351000 {
> -		compatible = "foo,i-leak-current";
> -		reg = <0x12351000 0x1000>;
> -		power-domains = <&power 0>, <&power 1> ;
> -		power-domain-names = "io", "clk";
> -	};
> -
> -The first example above defines a typical PM domain consumer device, which is
> -located inside a PM domain with index 0 of a power controller represented by a
> -node with the label "power".
> -In the second example the consumer device are partitioned across two PM domains,
> -the first with index 0 and the second with index 1, of a power controller that
> -is represented by a node with the label "power".
> -
> -Optional properties:
> -- required-opps: This contains phandle to an OPP node in another device's OPP
> -  table. It may contain an array of phandles, where each phandle points to an
> -  OPP of a different device. It should not contain multiple phandles to the OPP
> -  nodes in the same OPP table. This specifies the minimum required OPP of the
> -  device(s), whose OPP's phandle is present in this property, for the
> -  functioning of the current device at the current OPP (where this property is
> -  present).
> -
> -Example:
> -- OPP table for domain provider that provides two domains.
> -
> -	domain0_opp_table: opp-table0 {
> -		compatible = "operating-points-v2";
> -
> -		domain0_opp_0: opp-1000000000 {
> -			opp-hz = /bits/ 64 <1000000000>;
> -			opp-microvolt = <975000 970000 985000>;
> -		};
> -		domain0_opp_1: opp-1100000000 {
> -			opp-hz = /bits/ 64 <1100000000>;
> -			opp-microvolt = <1000000 980000 1010000>;
> -		};
> -	};
> -
> -	domain1_opp_table: opp-table1 {
> -		compatible = "operating-points-v2";
> -
> -		domain1_opp_0: opp-1200000000 {
> -			opp-hz = /bits/ 64 <1200000000>;
> -			opp-microvolt = <975000 970000 985000>;
> -		};
> -		domain1_opp_1: opp-1300000000 {
> -			opp-hz = /bits/ 64 <1300000000>;
> -			opp-microvolt = <1000000 980000 1010000>;
> -		};
> -	};
> -
> -	power: power-controller@12340000 {
> -		compatible = "foo,power-controller";
> -		reg = <0x12340000 0x1000>;
> -		#power-domain-cells = <1>;
> -		operating-points-v2 = <&domain0_opp_table>, <&domain1_opp_table>;
> -	};
> -
> -	leaky-device0@12350000 {
> -		compatible = "foo,i-leak-current";
> -		reg = <0x12350000 0x1000>;
> -		power-domains = <&power 0>;
> -		required-opps = <&domain0_opp_0>;
> -	};
> -
> -	leaky-device1@12350000 {
> -		compatible = "foo,i-leak-current";
> -		reg = <0x12350000 0x1000>;
> -		power-domains = <&power 1>;
> -		required-opps = <&domain1_opp_1>;
> -	};
> -
> -[1]. Documentation/devicetree/bindings/power/domain-idle-state.txt
> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> index eb35b22f9e23..386eeed6a887 100644
> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> @@ -12,7 +12,7 @@ Required Properties:
>   - #power-domain-cells: number of cells in Power domain specifier
>  	must be 1.
>   - operating-points-v2: Phandle to the OPP table for the Power domain.
> -	Refer to Documentation/devicetree/bindings/power/power_domain.txt
> +	Refer to Documentation/devicetree/bindings/power/power-domain-consumers.yaml
>  	and Documentation/devicetree/bindings/opp/opp.txt for more details
>  
>  Refer to <dt-bindings/power/qcom-rpmpd.h> for the level values for
> diff --git a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
> index eae2a880155a..8cd804980119 100644
> --- a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
> +++ b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
> @@ -43,7 +43,7 @@ Example:
>  
>  Devices residing in a power area must refer to that power area, as documented
>  by the generic PM domain bindings in
> -Documentation/devicetree/bindings/power/power_domain.txt.
> +Documentation/devicetree/bindings/power/power-domain-consumers.yaml.
>  
>  Required properties:
>    - power-domains: A phandle and symbolic PM domain specifier, as defined in
> diff --git a/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt b/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
> index beda7d2efc30..49aba15dff8b 100644
> --- a/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
> +++ b/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
> @@ -29,7 +29,7 @@ Optional nodes:
>  
>  Each of the PM domain nodes represents a PM domain, as documented by the
>  generic PM domain bindings in
> -Documentation/devicetree/bindings/power/power_domain.txt.
> +Documentation/devicetree/bindings/power/power-domain.yaml.
>  
>  The nodes should be named by the real power area names, and thus their names
>  should be unique.
> diff --git a/Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt b/Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
> index 8d1b8200ebd0..54b9f9d0f90f 100644
> --- a/Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
> +++ b/Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
> @@ -4,7 +4,7 @@ Device Tree Bindings for the Xilinx Zynq MPSoC PM domains
>  The binding for zynqmp-power-controller follow the common
>  generic PM domain binding[1].
>  
> -[1] Documentation/devicetree/bindings/power/power_domain.txt
> +[1] Documentation/devicetree/bindings/power/power-domain.yaml
>  
>  == Zynq MPSoC Generic PM Domain Node ==
>  
> diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
> index 3b7d32956391..72ff033565e5 100644
> --- a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
> +++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
> @@ -26,7 +26,7 @@ Optional properties:
>      system power.  This node follows the power controller bindings[3].
>  
>  [1] Documentation/devicetree/bindings/reset/reset.txt
> -[2] Documentation/devicetree/bindings/power/power_domain.txt
> +[2] Documentation/devicetree/bindings/power/power-domain.yaml
>  [3] Documentation/devicetree/bindings/power/power-controller.txt
>  
>  Example:
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> index 876693a7ada5..8f469d85833b 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> +++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> @@ -8,7 +8,7 @@ The System Power Manager (SPM) inside the SCPSYS is for the MTCMOS power
>  domain control.
>  
>  The driver implements the Generic PM domain bindings described in
> -power/power_domain.txt. It provides the power domains defined in
> +power/power-domain.yaml. It provides the power domains defined in
>  - include/dt-bindings/power/mt8173-power.h
>  - include/dt-bindings/power/mt6797-power.h
>  - include/dt-bindings/power/mt2701-power.h
> diff --git a/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
> index f541d1f776a2..6217e64309de 100644
> --- a/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
> +++ b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
> @@ -12,7 +12,7 @@ PM Domain Node
>  ==============
>  The PM domain node represents the global PM domain managed by the PMMC, which
>  in this case is the implementation as documented by the generic PM domain
> -bindings in Documentation/devicetree/bindings/power/power_domain.txt.  Because
> +bindings in Documentation/devicetree/bindings/power/power-domain.yaml.  Because
>  this relies on the TI SCI protocol to communicate with the PMMC it must be a
>  child of the pmmc node.
>  
> diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt b/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt
> index 5bfcc0b4d6b9..ee0d6c28978f 100644
> --- a/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt
> +++ b/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt
> @@ -64,12 +64,12 @@ For Tegra210:
>  For Tegra210 and Tegra186:
>  - power-domains: A list of PM domain specifiers that reference each power-domain
>    used by the xHCI controller. This list must comprise of a specifier for the
> -  XUSBA and XUSBC power-domains. See ../power/power_domain.txt and
> +  XUSBA and XUSBC power-domains. See ../power/power-domain-consumers.yaml and
>    ../arm/tegra/nvidia,tegra20-pmc.txt for details.
>  - power-domain-names: A list of names that represent each of the specifiers in
>    the 'power-domains' property. Must include 'xusb_ss' and 'xusb_host' which
>    represent the power-domains XUSBA and XUSBC, respectively. See
> -  ../power/power_domain.txt for details.
> +  ../power/power-domain-consumers.yaml for details.
>  
>  Optional properties:
>  --------------------
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 296de2b51c83..a1a2237c1cc6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6883,7 +6883,7 @@ L:	linux-pm@vger.kernel.org
>  S:	Supported
>  F:	drivers/base/power/domain*.c
>  F:	include/linux/pm_domain.h
> -F:	Documentation/devicetree/bindings/power/power_domain.txt
> +F:	Documentation/devicetree/bindings/power/power-domain*.yaml
>  
>  GENERIC RESISTIVE TOUCHSCREEN ADC DRIVER
>  M:	Eugen Hristev <eugen.hristev@microchip.com>
> 

